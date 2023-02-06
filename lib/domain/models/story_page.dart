import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_english_story/service/story_book/story_page_constant.dart';

class StudyPage {
  final String pageDescription;
  final String? pageImgUrl;
  final int pageOrder;
  final String prompt;
  final String docId;

  StudyPage({
    required this.pageDescription,
    required this.pageImgUrl,
    required this.pageOrder,
    required this.prompt,
    required this.docId, 
  });

  factory StudyPage.fromSnapshot(
          QueryDocumentSnapshot<Map<String, dynamic>> snapshot) =>
      StudyPage(
        docId: snapshot.id,
        pageDescription: snapshot.data()[pageDescriptionFieldName].maybeEmpty(),
        pageImgUrl: snapshot.data()[pageImgUrlFieldName],
        pageOrder: snapshot.data()[pageOrderFieldName].maybeZero(),
        prompt: snapshot.data()[storyPagePromptFieldName].maybeEmpty(),
      );
}
