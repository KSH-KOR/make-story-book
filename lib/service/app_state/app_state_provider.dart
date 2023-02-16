import 'package:flutter/cupertino.dart';
import 'package:my_english_story/common/enums/vocab_category.dart';
import 'package:my_english_story/domain/models/my_image.dart';
import 'package:my_english_story/domain/models/quiz.dart';
import 'package:my_english_story/domain/models/story_book.dart';
import 'package:my_english_story/domain/models/study_page.dart';
import 'package:my_english_story/domain/models/vocab.dart';
import 'package:my_english_story/service/firebase_firestore/story_book_service.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/auth_user.dart';
import 'app_state_exception.dart';

class AppStateProvider extends ChangeNotifier {

  AuthUser? nonSyncronizedUser;
  
  final Map<String, bool> appMode = {
    AppStateFieldName.studyModeFieldName: false,
    AppStateFieldName.quizModeFieldName: false,
    AppStateFieldName.makeMineModeFieldName: false,
  };

  bool get isStudyMode =>
      appMode[AppStateFieldName.studyModeFieldName] ?? false;
  bool get isquizMode => appMode[AppStateFieldName.quizModeFieldName] ?? false;
  bool get ismakeMineMode =>
      appMode[AppStateFieldName.makeMineModeFieldName] ?? false;

  void changeMode({required AppMode mode}) {
    switch (mode) {
      case AppMode.studyMode:
        appMode[AppStateFieldName.studyModeFieldName] = true;
        appMode[AppStateFieldName.quizModeFieldName] = false;
        appMode[AppStateFieldName.makeMineModeFieldName] = false;
        break;
      case AppMode.quizMode:
        appMode[AppStateFieldName.studyModeFieldName] = false;
        appMode[AppStateFieldName.quizModeFieldName] = true;
        appMode[AppStateFieldName.makeMineModeFieldName] = false;
        break;
      case AppMode.makeMineMode:
        appMode[AppStateFieldName.studyModeFieldName] = false;
        appMode[AppStateFieldName.quizModeFieldName] = false;
        appMode[AppStateFieldName.makeMineModeFieldName] = true;
        break;
    }
    notifyListeners();
  }

  StoryBook? _fetchedStoryBook;

  StoryBook get fetchedStoryBook {
    if (_fetchedStoryBook == null) throw StoryBookHasNotBeenFetchedException();
    return _fetchedStoryBook!;
  }

  void fetchStoryBook({required StoryBook storyBook}) {
    _fetchedStoryBook = storyBook;
    notifyListeners();
  }

  Iterable<StudyPage>? _fetchedStudyPages;

  Iterable<StudyPage> get fetchedStudyPages {
    if (_fetchedStudyPages == null) throw StudyPageHasNotBeenFetchedException();
    return _fetchedStudyPages!;
  }

  Future<void> fetchStudyPages() async {
    if (_fetchedStoryBook == null) throw StoryBookHasNotBeenFetchedException();
    _fetchedStudyPages = await StoryBookService.firebase()
        .getStudyPagesByPageOrderAsList(docId: _fetchedStoryBook!.docId!);
    notifyListeners();
  }

  Iterable<Quiz>? _fetchedQuizPages;

  Iterable<Quiz> get fetchedQuizPages {
    if (_fetchedQuizPages == null) throw QuizPageHasNotBeenFetchedException();
    return _fetchedQuizPages!;
  }

  Future<void> fetchQuizPages() async {
    if (_fetchedStoryBook == null) throw QuizPageHasNotBeenFetchedException();
    _fetchedQuizPages = await StoryBookService.firebase()
        .getQuizPagesByPageOrderAsList(docId: _fetchedStoryBook!.docId!);
    notifyListeners();
  }

  int _currentStudyPage = 0;

  void setCurrentStudyPage(int setVal){
    if (_fetchedStudyPages == null) throw StudyPageHasNotBeenFetchedException();
    final int studyPagesLength = _fetchedStudyPages!.length;
    if(setVal > studyPagesLength || setVal < 0) throw InvalidIndexForStudyPageException();
    _currentStudyPage = setVal;
    notifyListeners();
  }

  StudyPage getStudyPageByIndex({required int targetPage}){
    if (_fetchedStudyPages == null) throw StudyPageHasNotBeenFetchedException();
    return _fetchedStudyPages!.toList()[_currentStudyPage];
  }

  StudyPage getPreviousStudyPage(){
    setCurrentStudyPage(_currentStudyPage - 1);
    return getStudyPageByIndex(targetPage: _currentStudyPage);
  }

  StudyPage getNextStudyPage(){
    setCurrentStudyPage(_currentStudyPage + 1);
    return getStudyPageByIndex(targetPage: _currentStudyPage);
  }

  int _currentQuizPage = 0;

  void setCurrentQuizPage(int setVal){
    if (_fetchedQuizPages == null) throw QuizPageHasNotBeenFetchedException();
    final int quizPagesLength = _fetchedQuizPages!.length;
    if(setVal > quizPagesLength || setVal < 0) throw InvalidIndexForQuizPageException();
    _currentQuizPage = setVal;
    notifyListeners();
  }

  Quiz getQuizPageByIndex({required int targetPage}){
    if (_fetchedQuizPages == null) throw QuizPageHasNotBeenFetchedException();
    return _fetchedQuizPages!.toList()[targetPage];
  }

  Quiz getPreviousQuizPage(){
    setCurrentQuizPage(_currentQuizPage - 1);
    return getQuizPageByIndex(targetPage: _currentQuizPage);
  }

  Quiz getNextQuizPage(){
    setCurrentQuizPage(_currentQuizPage + 1);
    return getQuizPageByIndex(targetPage: _currentQuizPage);
  }

  final List<Vocab> choosenVocabs = [];

  void removeChoosenVocabsByVocabCategory({required VocabCategory targetCategory}) {
    choosenVocabs.removeWhere((element) => element.vocabCategory == targetCategory,);
    notifyListeners();
  }

  bool removeChoosenVocabsByVocabId({required String vocabId}) {
    final int beforeRemove = choosenVocabs.length;
    choosenVocabs.removeWhere((element) => element.vocabId == vocabId,);
    notifyListeners();
    return beforeRemove != choosenVocabs.length;
  }

  void addVocabForQuiz({required Vocab vocab}) {
    choosenVocabs.add(vocab);
    notifyListeners();
  }

  void addOrRemoveAnswerVocabForQuiz({required Vocab vocab}){
    if(removeChoosenVocabsByVocabId(vocabId: vocab.vocabId)){
      return;
    }
    removeChoosenVocabsByVocabCategory(targetCategory: vocab.vocabCategory);
    addVocabForQuiz(vocab: vocab);
  }

  bool checkAnswer({required Quiz quiz}){
    final answerVocabList = quiz.answerVocabList;
    if(answerVocabList.length != choosenVocabs.length) return false;
    answerVocabList.sort(compare);
    choosenVocabs.sort(compare);
    for(int i=0; i< choosenVocabs.length; i++){
      if(choosenVocabs[i].vocabId != answerVocabList[i].vocabId) return false;
    }
    return true;
  }

  int compare(Vocab a, Vocab b){
    return a.vocabId.compareTo(b.vocabId);
  }

  VocabCategory? _currentVocabCategoryForQuiz;

  VocabCategory get currentVocabCategoryForQuiz {
    if(_currentVocabCategoryForQuiz == null) setCurrentVocabCategoryForQuiz(catrgory: VocabCategory.verb);
    return _currentVocabCategoryForQuiz!;
  } 

  void setCurrentVocabCategoryForQuiz({required VocabCategory catrgory}){
    _currentVocabCategoryForQuiz = catrgory;
    notifyListeners();
  }

  final List<StudyPage> _myStudyPage = [];
  String? _generatedImageUrl;

  Future<String> generateImage(){
    final Quiz quiz = getQuizPageByIndex(targetPage: _currentQuizPage);
    final String promptForImageGeneration = quiz.prompt;
    _generatedImageUrl = "url";
    if(_generatedImageUrl == null) throw QuizImageHasNotBeenGeneratedException();
    return Future.delayed(const Duration(seconds: 1), () => _generatedImageUrl!,);
  } 

  void addStudyPageToLocalList({required StudyPage studyPage}) => _myStudyPage.add(studyPage);

  StudyPage createMyStudyPage({required String generatedImageUrl}){
    final StudyPage studyPageCorrespondingToCurrentQuiz = getStudyPageByIndex(targetPage: _currentQuizPage);
    final studyPage = StudyPage(
      pageDescription: studyPageCorrespondingToCurrentQuiz.pageDescription,
      pageImgUrl: generatedImageUrl,
      pageOrder: studyPageCorrespondingToCurrentQuiz.pageOrder,
      prompt: studyPageCorrespondingToCurrentQuiz.prompt,
      studyPageId: const Uuid().v4(),
      vocabList: studyPageCorrespondingToCurrentQuiz.vocabList,
    );
    addStudyPageToLocalList(studyPage: studyPage);
    return studyPage;
  }

  Future<StoryBook> createMyStoryPage({required String bookCoverImgUrl, required String userId}) async {
    if(_fetchedStoryBook == null) throw StoryBookHasNotBeenFetchedException();
    if(_fetchedQuizPages == null) throw QuizPageHasNotBeenFetchedException();
    if(_myStudyPage.length != _fetchedQuizPages!.length) throw AllStudyPagesInTheStoryHaveNotBeenCreatedException();
    
    final myStoryBook = await StoryBookService.firebase().createMyStoryBook(
      studyPages: _myStudyPage, 
      bookCoverImgUrl: bookCoverImgUrl, 
      targetStoryBook: _fetchedStoryBook!,
      userId: userId,
    );
    return myStoryBook;
  }
}

class AppStateFieldName {
  static const String studyModeFieldName = 'study-mode';
  static const String quizModeFieldName = 'quiz-mode';
  static const String makeMineModeFieldName = 'make-mine-mode';
}

enum AppMode {
  studyMode,
  quizMode,
  makeMineMode,
}
