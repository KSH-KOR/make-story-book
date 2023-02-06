import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_english_story/domain/models/story_book.dart';
import 'package:my_english_story/domain/models/study_page.dart';
import 'package:my_english_story/service/story_book/story_book_provider.dart';

import '../../common/constants/firestore_fieldnames/story_book_firestore_fieldname.dart';
import '../../common/constants/firestore_fieldnames/study_page_firestore_fieldname.dart';

class FirebaseStoryBookProvider extends StoryBookProvider {
  final _storyBookCollection =
      FirebaseFirestore.instance.collection(storyBookCollectionName);
  CollectionReference<Map<String, dynamic>> _getStudyCollection(
          {required String docId}) =>
      _storyBookCollection.doc(docId).collection(studyCollectionName);
  @override
  Stream<Iterable<StoryBook>> getStoryBooksByLevel({int level = 1}) =>
      _storyBookCollection
          .where(levelFieldName, isEqualTo: level)
          .snapshots()
          .map(((event) => event.docs.map(
                (snapshot) => StoryBook.fromSnapshot(snapshot),
              )));

  Future<void> test() async {
    final doc =
        await _storyBookCollection.where(levelFieldName, isEqualTo: 1).get();
    log(doc.docs.first.data()[storyBookIdFieldName]);
  }

  @override
  Stream<Iterable<StudyPage>> getStudyPagesByPageOrder(
          {required String docId}) =>
      _getStudyCollection(docId: docId)
          .orderBy(pageOrderFieldName)
          .snapshots()
          .map(((event) => event.docs.map(
                (snapshot) => StudyPage.fromSnapshot(snapshot),
              )));
}
