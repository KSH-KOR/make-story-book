import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_english_story/common/constants/firestore_fieldnames/vocab_firestore_fieldname.dart';

import '../../common/enums/vocab_category.dart';

class Vocab {
  final VocabCategory vocabCategory;
  final String meaning;
  final String prompt;
  final String vocabId;
  final String? vocabImgRrl;
  final String? docId;

  Vocab({
    required this.vocabCategory,
    required this.meaning,
    required this.prompt,
    required this.vocabId,
    required this.vocabImgRrl,
    this.docId,
  });

  factory Vocab.fromSnapshot(
          QueryDocumentSnapshot<Map<String, dynamic>> snapshot) =>
      Vocab(
        meaning: snapshot.data()[meaningFieldName].maybeEmpty(),
        prompt: snapshot.data()[meaningFieldName].maybeEmpty(),
        vocabCategory:
            snapshot.data()[meaningFieldName].maybeEmpty().toVocabCategory(),
        vocabId: snapshot.data()[meaningFieldName].maybeEmpty(),
        vocabImgRrl: snapshot.data()[meaningFieldName],
        docId: snapshot.id,
      );

  factory Vocab.fromMap(
          Map<String, dynamic> map) =>
      Vocab(
        meaning: map[meaningFieldName].maybeEmpty(),
        prompt: map[meaningFieldName].maybeEmpty(),
        vocabCategory:
            map[meaningFieldName].maybeEmpty().toVocabCategory(),
        vocabId: map[meaningFieldName].maybeEmpty(),
        vocabImgRrl: map[meaningFieldName],
      );
}
