import 'package:cloud_firestore/cloud_firestore.dart';
import '../../common/extensions/string/maybe_empty.dart';
import '../../common/extensions/int/maybe_zero.dart';
import 'package:my_english_story/common/constants/firestore_fieldnames/study_page_firestore_fieldname.dart';
import 'package:my_english_story/domain/models/vocab.dart';

class StudyPage {
  final String pageDescription;
  final String? pageImgUrl;
  final int pageOrder;
  final String prompt;
  final String docId;
  final String studyPageId;
  final List<Vocab> vocabList;

  StudyPage( {
    required this.pageDescription,
    required this.pageImgUrl,
    required this.pageOrder,
    required this.prompt,
    required this.docId,
    required this.studyPageId,
    required this.vocabList,
  });

  factory StudyPage.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return StudyPage(
      docId: snapshot.id,
      pageDescription: MaybeEmpty(snapshot.data()[pageDescriptionFieldName]).maybeEmpty(),
      pageImgUrl: snapshot.data()[pageImgUrlFieldName],
      pageOrder: MaybeZero(snapshot.data()[pageOrderFieldName]).maybeZero(),
      prompt: MaybeEmpty(snapshot.data()[storyPagePromptFieldName]).maybeEmpty(),
      studyPageId: MaybeEmpty(snapshot.data()[studyPageIdFieldName]).maybeEmpty(),
      vocabList: snapshot.data()[vocabFieldName] is Iterable
          ? List.from(snapshot.data()[vocabFieldName])
              .map((element) => Vocab.fromMap(element))
              .toList()
          : [],
    );
  }

  factory StudyPage.fromDocSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
        if(!snapshot.exists){
          throw Exception();
        }
        final Map snapshotData = snapshot.data()!;
    return StudyPage(
      docId: snapshot.id,
      pageDescription: MaybeEmpty(snapshotData[pageDescriptionFieldName]).maybeEmpty(),
      pageImgUrl: snapshotData[pageImgUrlFieldName],
      pageOrder: MaybeZero(snapshotData[pageOrderFieldName]).maybeZero(),
      prompt: MaybeEmpty(snapshotData[storyPagePromptFieldName]).maybeEmpty(),
      studyPageId: MaybeEmpty(snapshotData[studyPageIdFieldName]).maybeEmpty(),
      vocabList: snapshotData[vocabFieldName] is Iterable
          ? List.from(snapshotData[vocabFieldName])
              .map((element) => Vocab.fromMap(element))
              .toList()
          : [],
    );
  }
}
