import 'package:cloud_firestore/cloud_firestore.dart';

class WordCard{
  final String? wordCardCoverImageDownloadUrl;
  final String? prompt;
  final String? wordCardId;
  final WordCategory? wordCategory;

  WordCard({
    required this.wordCardCoverImageDownloadUrl,
    required this.prompt,
    required this.wordCardId,
    required this.wordCategory, 
  });

  factory WordCard.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snap){
    return WordCard(
      prompt: snap.data()[promptFieldName] is String ? snap.data()[promptFieldName] : null,
      wordCardCoverImageDownloadUrl: snap.data()[wordCardCoverImageDownloadUrlFieldName] is String ? snap.data()[wordCardCoverImageDownloadUrlFieldName] : null,
      wordCardId: snap.data()[wordCardIdFieldName] is String ? snap.data()[wordCardIdFieldName] : null,
      wordCategory: snap.data()[wordCategoryFieldName] is String ? castStringToWordCategory(snap.data()[wordCategoryFieldName]) : null,
    );
  }

  static WordCategory? castStringToWordCategory(String input){
    for(WordCategory wordCategory in WordCategory.values){
      if(wordCategory.toString() == input) return wordCategory;
    }
    return null;
  }
}

const String wordCardCoverImageDownloadUrlFieldName = "word-card-cover-image-download-url";
const String promptFieldName = 'prompt';
const String wordCardIdFieldName = 'word-card-id';
const String wordCategoryFieldName = 'word-category';

enum WordCategory{
  verb, noun
}