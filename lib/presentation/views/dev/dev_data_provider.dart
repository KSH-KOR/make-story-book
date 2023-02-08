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

  final List<Vocab> vocabList = [];

  void clearVocabInputs(){
    selectedVocabCategory = null;
    vocabImagePath = null;
    vocabMeaning = null;
    vocabPrompt = null;
  }
  void clearStudyPageInputs(){
    pageDescriptionText = null;
    pagePromptText = null;
    studyPageId = null;
    selectedPageOrder = null;
    imagePath = null;
  }
}