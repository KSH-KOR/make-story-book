import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_english_story/common/constants/firestore_fieldnames/study_page_firestore_fieldname.dart';
import 'package:my_english_story/domain/models/vocab.dart';

class StudyPage {
  final String pageDescription;
  final String? pageImgUrl;
  final int pageOrder;
  final String prompt;
  final String docId;
  final List<Vocab> vocabList;

  StudyPage({
    required this.pageDescription,
    required this.pageImgUrl,
    required this.pageOrder,
    required this.prompt,
    required this.docId,
    required this.vocabList,
  });

  factory StudyPage.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return StudyPage(
      docId: snapshot.id,
      pageDescription: snapshot.data()[pageDescriptionFieldName].maybeEmpty(),
      pageImgUrl: snapshot.data()[pageImgUrlFieldName],
      pageOrder: snapshot.data()[pageOrderFieldName].maybeZero(),
      prompt: snapshot.data()[storyPagePromptFieldName].maybeEmpty(),
      vocabList: snapshot.data()["vocab"] is Iterable
          ? List.from(snapshot.data()["vocab"])
              .map((element) => Vocab.fromMap(element))
              .toList()
          : [],
    );
  }
}
