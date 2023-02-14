import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_english_story/domain/models/study_page.dart';
import 'package:my_english_story/domain/models/story_book.dart';
import 'package:my_english_story/domain/models/quiz.dart';
import 'package:my_english_story/domain/models/vocab.dart';
import 'package:my_english_story/service/firebase_firestore/firebase_firestore_provider.dart';
import '../../common/enums/vocab_category.dart';
import '../../common/extensions/string/split_containing_patterns.dart';

import 'story_book_provider.dart';

class StoryBookService implements StoryBookProvider {
  final StoryBookProvider provider;
  const StoryBookService(this.provider);

  factory StoryBookService.firebase() =>
      StoryBookService(FirebaseFirestoreProvider());

  List<dynamic> getTokens({required String inputString, RegExp? regex}) {
    final result = SplitContainingPatterns(inputString)
        .splitContainingPatterns(
            pattern: regex ?? RegExp(r'(#)|(@)'), shouldTrim: true)
        .map((e) {
      if (e == "#") {
        return VocabCategory.noun;
      } else if (e == "@") {
        return VocabCategory.verb;
      } else {
        return e;
      }
    }).toList();
    return result;
  }

  Iterable<Widget> convertQuestionsToWidgets({required String question}) {
    return getTokens(inputString: question).map((e) {
      if (e.runtimeType == VocabCategory) {
        return Container(
            color: Colors.amber, child: Text("[Fill here - ${e.toString()}]"));
      } else {
        return Text(e);
      }
    });
  }

  Widget test(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Hello ',
        style: DefaultTextStyle.of(context).style,
        children: const <TextSpan>[
          TextSpan(text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: ' world!'),
        ],
      ),
    );
  }

  @override
  Stream<Iterable<Quiz>> getQuizPagesByPageOrder({required String docId}) =>
      provider.getQuizPagesByPageOrder(docId: docId);
  
  Future<Iterable<Quiz>> getQuizPagesByPageOrderAsList({required String docId}) async => await getQuizPagesByPageOrder(docId: docId).first;

  @override
  Stream<Iterable<StoryBook>> getStoryBooksByLevel({int level = 1}) =>
      provider.getStoryBooksByLevel(level: level);

  Future<Iterable<StoryBook>> getStoryBooksByLevelAsList({int level = 1}) async => await getStoryBooksByLevel(level: level).first;

  @override
  Stream<Iterable<StudyPage>> getStudyPagesByPageOrder(
          {required String docId}) =>
      provider.getStudyPagesByPageOrder(docId: docId);

  Future<Iterable<StudyPage>> getStudyPagesByPageOrderAsList({required String docId}) async => await getStudyPagesByPageOrder(docId: docId).first;


  @override
  Future<Quiz> createNewQuizPage(
          {required String answer,
          required String prompt,
          required String question,
          required String? quizImgUrl,
          required int quizOrder,
          required String storyBookDocId,
          required List<Vocab> vocabAnswer,
          String? quizId}) =>
      provider.createNewQuizPage(
        vocabAnswer: vocabAnswer,
          answer: answer,
          prompt: prompt,
          question: question,
          quizImgUrl: quizImgUrl,
          quizOrder: quizOrder,
          storyBookDocId: storyBookDocId,
          quizId: quizId);

  @override
  Future<StoryBook> createNewStoryBook(
          {required String bookTitle,
          required int level,
          required String bookCoverImgUrl,
          String? storyBookId}) =>
      provider.createNewStoryBook(
          bookTitle: bookTitle,
          level: level,
          bookCoverImgUrl: bookCoverImgUrl,
          storyBookId: storyBookId);

  @override
  Future<StudyPage> createNewStudyPage(
          {required String pageDescription,
          required String pageImgUrl,
          required int pageOrder,
          required String prompt,
          required String storyBookDocId,
          required List<Vocab> vocabList,
          String? studyPageId}) =>
      provider.createNewStudyPage(
          pageDescription: pageDescription,
          pageImgUrl: pageImgUrl,
          pageOrder: pageOrder,
          prompt: prompt,
          storyBookDocId: storyBookDocId,
          vocabList: vocabList,
          studyPageId: studyPageId);

  @override
  Future<Vocab> createNewVocab({required Vocab vocab}) =>
      provider.createNewVocab(vocab: vocab);
}
