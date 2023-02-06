import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_english_story/common/constants/firestore_fieldnames/vocab_firestore_fieldname.dart';
import '../../common/extensions/string/maybe_empty.dart';
import '../../common/extensions/string/to_enum.dart';
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
        meaning: MaybeEmpty(snapshot.data()[meaningFieldName]).maybeEmpty(),
        prompt: MaybeEmpty(snapshot.data()[meaningFieldName]).maybeEmpty(),
        vocabCategory:
            MaybeEmpty(snapshot.data()[meaningFieldName]).maybeEmpty().toVocabCategory(),
        vocabId: MaybeEmpty(snapshot.data()[meaningFieldName]).maybeEmpty(),
        vocabImgRrl: snapshot.data()[meaningFieldName],
        docId: snapshot.id,
      );

  factory Vocab.fromMap(
          Map<String, dynamic> map) =>
      Vocab(
        meaning: MaybeEmpty(map[meaningFieldName]).maybeEmpty(),
        prompt: MaybeEmpty(map[meaningFieldName]).maybeEmpty(),
        vocabCategory:
            MaybeEmpty(map[meaningFieldName]).maybeEmpty().toVocabCategory(),
        vocabId: MaybeEmpty(map[meaningFieldName]).maybeEmpty(),
        vocabImgRrl: map[meaningFieldName],
      );
}
