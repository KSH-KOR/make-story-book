import 'package:my_english_story/domain/models/story_book.dart';

import '../../domain/models/auth_user.dart';
import '../../domain/models/quiz.dart';
import '../../domain/models/study_page.dart';
import '../../domain/models/vocab.dart';

abstract class StoryBookProvider{
  Stream<Iterable<StoryBook>> getStoryBooksByLevel({int level = 1});
  Stream<Iterable<StudyPage>> getStudyPagesByPageOrder({required String docId});
  Stream<Iterable<Quiz>> getQuizPagesByPageOrder({required String docId});
  Future<StoryBook> createNewStoryBook({
    required String bookTitle,
    required int level,
    required String bookCoverImgUrl,
    String? storyBookId,
  });
  Future<StudyPage> createNewStudyPage({
    required String pageDescription,
    required String pageImgUrl,
    required int pageOrder,
    required String prompt,
    required String storyBookDocId,
    required List<Vocab> vocabList,
    String? studyPageId,
  });
  Future<Quiz> createNewQuizPage({
    required List<Vocab> vocabAnswer,
    required String answer,
    required String prompt,
    required String question,
    required String? quizImgUrl,
    required int quizOrder,
    required String storyBookDocId,
    String? quizId,
  });
  Future<Vocab> createNewVocab({
    required Vocab vocab,
  });
  Future<StoryBook> createMyStoryBook({
      required List<StudyPage> studyPages,
      required StoryBook targetStoryBook,
      required String bookCoverImgUrl,
      String? storyBookId,
      required String userId,
  });
  Future<Vocab> createMyVocabs({
      required Vocab vocab,
      required String userId,
  });
}