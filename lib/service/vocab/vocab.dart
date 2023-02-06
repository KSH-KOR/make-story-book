import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_english_story/service/vocab/vocab_constant.dart';

import '../../common/enums/vocab_category.dart';

class Vocab {
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
        vocabCategory:
            snapshot.data()[meaningFieldName].maybeEmpty().toVocabCategory(),
        vocabId: snapshot.data()[meaningFieldName].maybeEmpty(),
        vocabImgRrl: snapshot.data()[meaningFieldName],
        docId: snapshot.id,
      );
}
