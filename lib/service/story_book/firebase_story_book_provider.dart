import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_english_story/service/story_book/story_book.dart';
import 'package:my_english_story/service/story_book/story_book_provider.dart';

import 'story_book_constant.dart';
import 'story_page_constant.dart';

class FirebaseStoryBookProvider extends StoryBookProvider{
  final _storyBookCollection =
         FirebaseFirestore.instance.collection(storyBookCollectionName);
  CollectionReference<Map<String, dynamic>> _getStudyCollection({required String docId}) =>
    _storyBookCollection.doc(docId).collection(studyCollectionName);
  @override
  Stream<Iterable<StoryBook>> getStoryBooksByLevel({int level = 1}) =>
      _storyBookCollection
          .where(levelFieldName, isEqualTo: level)
          .snapshots()
          .map(((event) => event.docs.map(
                (snapshot) => StoryBook.fromSnapshot(snapshot),
              )));
              
  @override
  Stream<Iterable<StoryBook>> getStudyPagesByPageOrder({required String docId}) =>
    _getStudyCollection(docId: docId).orderBy(pageOrderFieldName).snapshots().map(
      ((event) => event.docs.map(
                (snapshot) => StoryBook.fromSnapshot(snapshot),
              )));
  

}