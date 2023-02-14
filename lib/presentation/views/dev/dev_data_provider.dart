import 'package:my_english_story/domain/models/vocab.dart';

class DevDataProvider{
  static final DevDataProvider _singleton = DevDataProvider._internal();

  factory DevDataProvider() {
    return _singleton;
  }

  DevDataProvider._internal();

  String? storyBookId;
  String? storyBookDocId;

  String? studyPageId;
  String? pageDescriptionText;
  String? pagePromptText;

  int? selectedPageOrder;
  int? selectedVocabCategory;
  int? seletedLevel;

  String? imagePath;
  String? vocabImagePath;

  String? bookTitleText;

  String? vocabMeaning;
  String? vocabPrompt;

  String? quizPageId;

  final List<List<Vocab>> quizVocabAnswer = [];
  final List<String> quizAnswers = [];
  final List<String> quizPrompts = [];
  final List<String> quizQuestions = [];
  final List<String> quizImageUrl = [];

  final List<Vocab> vocabList = [];

  void clearVocabInputs(){
    selectedVocabCategory = null;
    vocabImagePath = null;
    vocabMeaning = null;
    vocabPrompt = null;
  }
  void clearStudyPageInputs(){
    quizVocabAnswer.add(vocabList);
    quizAnswers.add(pageDescriptionText ?? "");
    quizPrompts.add(pagePromptText ?? "");
    quizImageUrl.add(imagePath ?? "");

    pageDescriptionText = null;
    pagePromptText = null;
    studyPageId = null;
    selectedPageOrder = null;
    imagePath = null;
    vocabList.clear();
  }
  void clearQuizPageInputs(){
    quizVocabAnswer.clear();
    quizAnswers.clear();
    quizPrompts.clear();
    quizQuestions.clear();
  }
}