import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../../common/extensions/string/maybe_empty.dart';
import '../../common/extensions/int/maybe_zero.dart';
import '../../common/constants/firestore_fieldnames/story_book_firestore_fieldname.dart';

class StoryBook {
  final String bookTitle;
  final int level;
  final String storyBookId;
  final String? bookCoverImgUrl;
  final Timestamp? createdTimestamp;
  final String? docId;

  StoryBook({
    required this.bookTitle,
    required this.level,
    required this.storyBookId,
    required this.bookCoverImgUrl,
    this.createdTimestamp,
    this.docId,
  });

  

  Map<String, dynamic> toMap(){
    return {
      bookTitleFieldName: bookTitle,
      levelFieldName: level,
      storyBookIdFieldName: storyBookId,
      bookCoverImgUrlFieldName: bookCoverImgUrl,
      createdTimestampFieldName: createdTimestamp,
    };
  }

  factory StoryBook.fromStoryBookRes({required StoryBook targetStoryBook, required String newBookCoverImgUrl}){
    return StoryBook(
      bookTitle: targetStoryBook.bookTitle,
      level: targetStoryBook.level,
      storyBookId: const Uuid().v4(),
      bookCoverImgUrl: newBookCoverImgUrl,
    );
  }

  factory StoryBook.fromSnapshot(
          QueryDocumentSnapshot<Map<String, dynamic>> snapshot) =>
      StoryBook(
        docId: snapshot.id,
        bookCoverImgUrl: snapshot.data()[bookCoverImgUrlFieldName],
        bookTitle: MaybeEmpty(snapshot.data()[bookTitleFieldName]).maybeEmpty(),
        createdTimestamp:
            snapshot.data()[createdTimestampFieldName] as Timestamp,
        level: MaybeZero(snapshot.data()[levelFieldName]).maybeZero(),
        storyBookId: MaybeEmpty(snapshot.data()[storyBookIdFieldName]).maybeEmpty(),
      );

  factory StoryBook.fromDocSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
        if(!snapshot.exists){
          throw Exception();
        }
    return StoryBook(
      docId: snapshot.id,
      bookCoverImgUrl: snapshot.data()![bookCoverImgUrlFieldName],
      bookTitle: MaybeEmpty(snapshot.data()![bookTitleFieldName]).maybeEmpty(),
      createdTimestamp:
          snapshot.data()![createdTimestampFieldName] as Timestamp,
      level: MaybeZero(snapshot.data()![levelFieldName]).maybeZero(),
      storyBookId:
          MaybeEmpty(snapshot.data()![storyBookIdFieldName]).maybeEmpty(),
    );
  }
}
