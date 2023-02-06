import 'package:cloud_firestore/cloud_firestore.dart';

import 'story_book_constant.dart';

class StoryBook {
  final String bookTitle;
  final int level;
  final String storyBookId;
  final String? bookCoverImgUrl;
  final Timestamp createdTimestamp;
  final String docId;

  StoryBook({
    required this.bookTitle,
    required this.level,
    required this.storyBookId,
    required this.bookCoverImgUrl,
    required this.createdTimestamp,
    required this.docId,
  });

  factory StoryBook.fromSnapshot(
          QueryDocumentSnapshot<Map<String, dynamic>> snapshot) =>
      StoryBook(
        docId: snapshot.id,
        bookCoverImgUrl: snapshot.data()[bookCoverImgUrlFieldName],
        bookTitle: snapshot.data()[bookTitleFieldName].maybeEmpty(),
        createdTimestamp:
            snapshot.data()[createdTimestampFieldName] as Timestamp,
        level: snapshot.data()[levelFieldName].maybeZero(),
        storyBookId: snapshot.data()[storyBookIdFieldName].maybeEmpty(),
      );
}
