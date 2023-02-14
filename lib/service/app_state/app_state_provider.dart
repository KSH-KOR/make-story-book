import 'package:flutter/cupertino.dart';
import 'package:my_english_story/domain/models/quiz.dart';
import 'package:my_english_story/domain/models/story_book.dart';
import 'package:my_english_story/domain/models/study_page.dart';
import 'package:my_english_story/service/firebase_firestore/firebase_firestore_provider.dart';
import 'package:my_english_story/service/firebase_firestore/story_book_service.dart';

import 'app_state_exception.dart';

class AppStateProvider extends ChangeNotifier {
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
        .getStudyPagesByPageOrderAsList(docId: _fetchedStoryBook!.docId);
    notifyListeners();
  }

  Iterable<Quiz>? _fetchedQuizPages;

  Iterable<Quiz> get fetchedQuizPages {
    if (_fetchedQuizPages == null) throw QuizPageHasNotBeenFetchedException();
    return _fetchedQuizPages!;
  }

  Future<void> fetchQuizPages() async {
    if (_fetchedStoryBook == null) throw StoryBookHasNotBeenFetchedException();
    _fetchedQuizPages = await StoryBookService.firebase()
        .getQuizPagesByPageOrderAsList(docId: _fetchedStoryBook!.docId);
    notifyListeners();
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
