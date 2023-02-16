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
  final String? docId;
  final String studyPageId;
  final List<Vocab> vocabList;

  StudyPage({
    required this.pageDescription,
    required this.pageImgUrl,
    required this.pageOrder,
    required this.prompt,
    this.docId,
    required this.studyPageId,
    required this.vocabList,
  });

  Map<String, dynamic> toMap() {
    return {
      pageDescriptionFieldName: pageDescription,
      pageImgUrlFieldName: pageImgUrl,
      pageOrderFieldName: pageOrder,
      storyPagePromptFieldName: prompt,
      studyPageIdFieldName: studyPageId,
      vocabFieldName: vocabList,
    };
  }

  factory StudyPage.fromMap(Map<String, dynamic> map, String? docId) {
    return StudyPage(
      docId: docId,
      pageDescription: MaybeEmpty(map[pageDescriptionFieldName]).maybeEmpty(),
      pageImgUrl: map[pageImgUrlFieldName],
      pageOrder: MaybeZero(map[pageOrderFieldName]).maybeZero(),
      prompt: MaybeEmpty(map[storyPagePromptFieldName]).maybeEmpty(),
      studyPageId: MaybeEmpty(map[studyPageIdFieldName]).maybeEmpty(),
      vocabList: map[vocabFieldName] is Iterable
          ? List.from(map[vocabFieldName])
              .map((element) => Vocab.fromMap(element))
              .toList()
          : [],
    );
  }

  factory StudyPage.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    final snapshotData = snapshot.data();
    return StudyPage.fromMap(snapshotData, snapshot.id);
  }

  factory StudyPage.fromDocSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (!snapshot.exists || snapshot.data() == null) {
      throw Exception();
    }
    final snapshotData = snapshot.data()!;
    return StudyPage.fromMap(snapshotData, snapshot.id);
  }
}
