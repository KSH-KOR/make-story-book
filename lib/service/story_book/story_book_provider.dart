import 'package:my_english_story/domain/models/story_book.dart';

import '../../domain/models/study_page.dart';

abstract class StoryBookProvider{
  Stream<Iterable<StoryBook>> getStoryBooksByLevel({int level = 1});
  Stream<Iterable<StudyPage>> getStudyPagesByPageOrder({required String docId});
}