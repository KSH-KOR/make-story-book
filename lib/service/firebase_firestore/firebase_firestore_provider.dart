import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_english_story/common/constants/firestore_fieldnames/quiz_firestore_fieldname.dart';
import 'package:my_english_story/domain/models/story_book.dart';
import 'package:my_english_story/domain/models/study_page.dart';
import 'package:my_english_story/domain/models/word_card.dart';
import 'package:my_english_story/service/firebase_firestore/story_book_provider.dart';
import 'package:uuid/uuid.dart';

import '../../common/constants/firestore_fieldnames/story_book_firestore_fieldname.dart';
import '../../common/constants/firestore_fieldnames/study_page_firestore_fieldname.dart';
import '../../domain/models/quiz.dart';
import '../../domain/models/vocab.dart';

class FirebaseFirestoreProvider implements StoryBookProvider {
  final _storyBookCollection =
      FirebaseFirestore.instance.collection(storyBookCollectionName);
  final _vocabCollection =
      FirebaseFirestore.instance.collection(vocabCollectionName);
  
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


  @override
  Future<StoryBook> createNewStoryBook({
    required String bookTitle,
    required int level,
    required String bookCoverImgUrl,
    String? storyBookId,
  }) async {
    final FieldValue createdTimestamp = FieldValue.serverTimestamp();
    storyBookId ?? const Uuid().v4();
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

  @override
  Future<StudyPage> createNewStudyPage({
    required String pageDescription,
    required String pageImgUrl,
    required int pageOrder,
    required String prompt,
    required String storyBookDocId,
    required List<Vocab> vocabList,
    String? studyPageId,
  }) async {
    studyPageId ?? const Uuid().v4();
    final vocabListAsMap = vocabList.map((vocab) => vocab.toMap()).toList();
    final studyPageRef = await _getStudyCollection(docId: storyBookDocId).add({
      pageDescriptionFieldName: pageDescription,
      pageImgUrlFieldName: pageImgUrl,
      pageOrderFieldName: pageOrder,
      promptFieldName: prompt,
      vocabFieldName: vocabListAsMap,
      studyPageIdFieldName: studyPageId,
    });
    final studyPageDocSnapshot = await studyPageRef.get();
    return StudyPage.fromDocSnapshot(studyPageDocSnapshot);  
  }

  @override
  Future<Vocab> createNewVocab({
    required Vocab vocab,
  }) async {
    final vocabRef = await _vocabCollection.add(vocab.toMap());
    final vocabDocSnapshot = await vocabRef.get();
    return Vocab.fromDocSnapshot(vocabDocSnapshot);  
  }

  @override
  Future<Quiz> createNewQuizPage({
    required List<Vocab> vocabAnswer,
    required String answer,
    required String prompt,
    required String question,
    required String? quizImgUrl,
    required int quizOrder,
    required String storyBookDocId,
    String? quizId,
  }) async {
    quizId ?? const Uuid().v4();
    final vocabListAsMap = vocabAnswer.map((vocab) => vocab.toMap()).toList();
    final quizRef = await _getQuizCollection(docId: storyBookDocId).add({
      quizVocabAnswerFieldName: vocabListAsMap,
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
