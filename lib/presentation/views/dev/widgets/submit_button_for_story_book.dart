import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_english_story/presentation/views/dev/dev_data_provider.dart';

import '../../../../service/firebase_storage/storage_service.dart';
import '../../../../service/firebase_firestore/story_book_service.dart';
import 'get_story_book_path.dart';

class SubmitButtonStoryBook extends StatefulWidget {
  const SubmitButtonStoryBook({super.key});

  @override
  State<SubmitButtonStoryBook> createState() => _SubmitButtonStoryBookState();
}

class _SubmitButtonStoryBookState extends State<SubmitButtonStoryBook> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        if (DevDataProvider().bookTitleText == null ||
            DevDataProvider().seletedLevel == null ||
            DevDataProvider().imagePath == null) {
          log("error: fill the all information");
          return;
        }
        final downloadUrl = await StorageService.firebase()
            .uploadFileToFirebaseStorage(
                path: getStoryBookPath(
                    storyBookId: DevDataProvider().storyBookId!),
                fileName: DevDataProvider().storyBookId!,
                filePathFromLocalDevice: DevDataProvider().imagePath,
                context: context,
                shouldShowLoadingDialog: true);
        if (downloadUrl == null) {
          log("error: got null download url");
          return;
        }
        final storyBook = await StoryBookService.firebase().createNewStoryBook(
            bookTitle: DevDataProvider().bookTitleText!,
            level: DevDataProvider().seletedLevel! + 1,
            bookCoverImgUrl: downloadUrl,
            storyBookId: DevDataProvider().storyBookId!);
        setState(() {
          DevDataProvider().storyBookDocId = storyBook.docId;
        });
        log("added succesfully!");
      },
      child: const Text("Create story book"),
    );
  }
}
