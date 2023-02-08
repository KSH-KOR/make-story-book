import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_english_story/presentation/views/dev/dev_data_provider.dart';

import '../../../../service/firebase_storage/storage_service.dart';
import '../../../../service/story_book/story_book_service.dart';
import 'get_study_page_path.dart';

class SubmitButtonStudyPage extends StatelessWidget {
  const SubmitButtonStudyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
              onPressed: () async {
        if (DevDataProvider().studyPageId == null ||
            DevDataProvider().pageDescriptionText == null ||
            DevDataProvider().storyBookId == null ||
            DevDataProvider().storyBookDocId == null ||
            DevDataProvider().pagePromptText == null ||
            DevDataProvider().selectedPageOrder == null ||
            DevDataProvider().imagePath == null) {
                  log("error: fill the all information");
                  return;
                }
                final downloadUrl =
                    await StorageService.firebase().uploadFileToFirebaseStorage(
                  path: getStudyPagePath(storyBookId: DevDataProvider().storyBookId!),
                  fileName: DevDataProvider().studyPageId!,
                  filePathFromLocalDevice: DevDataProvider().imagePath,
                  context: context,
                  shouldShowLoadingDialog: true
                );
                if(downloadUrl == null){
                  log("error: got null download url");
                  return;
                } 
                await StoryBookService.firebase().createNewStudyPage(
                  studyPageId: DevDataProvider().studyPageId,
                  pageDescription: DevDataProvider().pageDescriptionText!,
                  pageImgUrl: downloadUrl,
                  pageOrder: DevDataProvider().selectedPageOrder! + 1,
                  prompt: DevDataProvider().pagePromptText!,
                  storyBookDocId: DevDataProvider().storyBookDocId!,
                  vocabList: DevDataProvider().vocabList,
                );
                DevDataProvider().vocabList.clear();
                log("added succesfully!");
              },
              child: const Text("Create study page"),
            );
  }
}
