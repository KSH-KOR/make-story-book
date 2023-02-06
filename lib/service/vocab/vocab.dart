import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_english_story/service/vocab/vocab_constant.dart';

class Vocab{
  final VocabCategory vocabCategory;
  final String meaning;
  final String prompt;
  final String vocabId;
  final String? vocabImgRrl;
  final String docId;

  Vocab({
    required this.vocabCategory,
    required this.meaning,
    required this.prompt,
    required this.vocabId,
    required this.vocabImgRrl,
    required this.docId, 
  });

  factory Vocab.fromSnapshot(
          QueryDocumentSnapshot<Map<String, dynamic>> snapshot) =>
      Vocab(
        meaning: snapshot.data()[meaningFieldName].maybeEmpty(),
        prompt: snapshot.data()[meaningFieldName].maybeEmpty(),
        vocabCategory: snapshot.data()[meaningFieldName].maybeEmpty().toVocabCategory(),
        vocabId: snapshot.data()[meaningFieldName].maybeEmpty(),
        vocabImgRrl: snapshot.data()[meaningFieldName],
        docId: snapshot.id,
      );
}

extension ToVocabCategory<T> on String{
  VocabCategory toVocabCategory() {
    if(isEmpty) return VocabCategory.hasNotBeenDefined;
    return VocabCategory.values.firstWhere((element) => element.toString() == this, orElse: () => VocabCategory.hasNotBeenDefined);
  }
}

extension MaybeEmpty on String?{
  String maybeEmpty(){
    return this != null ? this! : "";
  }
}


enum VocabCategory{
  noun, verb, hasNotBeenDefined
}