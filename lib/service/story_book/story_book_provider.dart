import 'package:my_english_story/service/story_book/story_book.dart';

abstract class StoryBookProvider{
  Stream<Iterable<StoryBook>> getStoryBooksByLevel({int level = 1});
  Stream<Iterable<StoryBook>> getStudyPagesByPageOrder({required String docId});
}