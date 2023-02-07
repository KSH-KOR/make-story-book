import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_english_story/common/constants/firestore_fieldnames/quiz_firestore_fieldname.dart';
import 'package:my_english_story/domain/models/story_book.dart';
import 'package:my_english_story/domain/models/study_page.dart';
import 'package:my_english_story/domain/models/word_card.dart';
import 'package:my_english_story/service/story_book/story_book_provider.dart';
import 'package:uuid/uuid.dart';

import '../../common/constants/firestore_fieldnames/story_book_firestore_fieldname.dart';
import '../../common/constants/firestore_fieldnames/study_page_firestore_fieldname.dart';
import '../../domain/models/quiz.dart';
import '../../domain/models/vocab.dart';

class FirebaseStoryBookProvider implements StoryBookProvider {
  final _storyBookCollection =
      FirebaseFirestore.instance.collection(storyBookCollectionName);
  
  CollectionReference<Map<String, dynamic>> _getStudyCollection(
          {required String docId}) =>
      _storyBookCollection.doc(docId).collection(studyCollectionName);
  
  CollectionReference<Map<String, dynamic>> _getQuizCollection(
      {required String docId}) =>
  _storyBookCollection.doc(docId).collection(quizCollectionName);

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

  @override
  Stream<Iterable<Quiz>> getQuizPagesByPageOrder({required String docId}) =>
    _getQuizCollection(docId: docId).orderBy(quizOrderFieldName)
          .snapshots()
          .map(((event) => event.docs.map(
                (snapshot) => Quiz.fromSnapshot(snapshot),
              )));


  Future<StoryBook> createNewStoryBook({
    required String bookTitle,
    required int level,
    required String bookCoverImgUrl,
  }) async {
    final FieldValue createdTimestamp = FieldValue.serverTimestamp();
    final String storyBookId = const Uuid().v4();
    final storyBookRef = await _storyBookCollection.add({
      bookTitleFieldName: bookTitle,
      levelFieldName: level,
      storyBookIdFieldName: storyBookId,
      bookCoverImgUrlFieldName: bookCoverImgUrl,
      createdTimestampFieldName: createdTimestamp,
    });
    final storyBookDocSnapshot = await storyBookRef.get();
    return StoryBook.fromDocSnapshot(storyBookDocSnapshot);  
  }

  Future<StudyPage> createNewStudyPage({
    required String pageDescription,
    required String pageImgUrl,
    required int pageOrder,
    required String prompt,
    required String storyBookDocId,
    required List<Vocab> vocabList,
  }) async {
    final String studyPageId = const Uuid().v4();
    final studyPageRef = await _getStudyCollection(docId: storyBookDocId).add({
      pageDescriptionFieldName: pageDescription,
      pageImgUrlFieldName: pageImgUrl,
      pageOrderFieldName: pageOrder,
      promptFieldName: prompt,
      vocabFieldName: vocabList,
      studyPageIdFieldName: studyPageId,
    });
    final studyPageDocSnapshot = await studyPageRef.get();
    return StudyPage.fromDocSnapshot(studyPageDocSnapshot);  
  }

  Future<Quiz> createNewQuizPage({
    required String answer,
    required String prompt,
    required String question,
    required String? quizImgUrl,
    required int quizOrder,
    required String storyBookDocId,
  }) async {
    final String quizId = const Uuid().v4();
    final quizRef = await _getQuizCollection(docId: storyBookDocId).add({
      quizAnswerFieldName: answer,
      quizPromptFieldName: prompt,
      quizQuestionFieldName: question,
      quizImgUrlFieldName: quizImgUrl,
      quizOrderFieldName: quizOrder,
      quizIdFieldName: quizId,
    });
    final quizDocSnapshot = await quizRef.get();
    return Quiz.fromDocSnapshot(quizDocSnapshot);  
  }
}
