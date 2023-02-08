import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_english_story/common/constants/firestorage_paths/story_res_path.dart';
import 'package:my_english_story/presentation/views/dev/image_picker.dart';
import 'package:my_english_story/presentation/views/dev/widgets/display_story_book_ids.dart';
import 'package:my_english_story/presentation/views/dev/widgets/enter_book_tite.dart';
import 'package:my_english_story/presentation/views/dev/widgets/enter_story_book_ids.dart';
import 'package:my_english_story/presentation/views/dev/widgets/enter_page_description.dart';
import 'package:my_english_story/presentation/views/dev/widgets/select_image.dart';
import 'package:my_english_story/presentation/views/dev/widgets/select_page_order.dart';
import 'package:my_english_story/presentation/views/dev/widgets/select_story_book_level.dart';
import 'package:my_english_story/presentation/views/dev/widgets/select_vocab.dart';
import 'package:my_english_story/presentation/views/dev/widgets/submit_button_for_story_book.dart';
import 'package:my_english_story/presentation/views/dev/widgets/submit_button_for_study_page.dart';
import 'package:my_english_story/service/firebase_storage/storage_service.dart';
import 'package:my_english_story/service/story_book/story_book_service.dart';
import 'package:uuid/uuid.dart';

import 'dev_data_provider.dart';
import 'widgets/display_added_vocab.dart';
import 'widgets/get_story_book_path.dart';


class CreateDataIntoFirebaseView extends StatefulWidget {
  const CreateDataIntoFirebaseView({super.key});

  @override
  State<CreateDataIntoFirebaseView> createState() => _CreateDataIntoFirebaseViewState();
}

class _CreateDataIntoFirebaseViewState extends State<CreateDataIntoFirebaseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [
          CreateStoryPage(),
          CreateStudyPage(),
        ],
      ),
    );
  }
}

class CreateStudyPage extends StatefulWidget {
  const CreateStudyPage({super.key});

  @override
  State<CreateStudyPage> createState() => _CreateStudyPageState();
}

class _CreateStudyPageState extends State<CreateStudyPage> {
  @override
  void initState() {
    super.initState();
    DevDataProvider().studyPageId = const Uuid().v4();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 100, left: 40, right: 40, bottom: 40),
        child: Column(
          children: const [
            SelectPageOrder(),
            Divider(),
            EnterPageDesAndPrompt(),
            Divider(),
            EnterStoryBookIds(),
            Divider(),
            SelectImage(),
            Divider(),
            DisplayAddedVocab(),
            SelectVocab(),
            Divider(),
            SubmitButtonStudyPage(),
            ],
        ),
      ),
    );
  }

}

class CreateStoryPage extends StatefulWidget {
  const CreateStoryPage({super.key});

  @override
  State<CreateStoryPage> createState() => _CreateStoryPageState();
}

class _CreateStoryPageState extends State<CreateStoryPage> {

  @override
  void initState() {
    super.initState();
    
    SchedulerBinding.instance.addPostFrameCallback((_) => showDialog(
      barrierDismissible: false,
      context: context, builder: ((context) {
      return AlertDialog(
        title: const Text("should generate story book id?"),
        actions: [
          OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("no"),
                ),
          OutlinedButton(
                  onPressed: () {
                    setState(() {
                      DevDataProvider().storyBookId = const Uuid().v4();
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("generate"),
                ),
        ],
      );
    })));
    if(DevDataProvider().storyBookId == null) DevDataProvider().storyBookId = const Uuid().v4();
    
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 100, left: 40, right: 40, bottom: 40),
        child: Column(
          children: const [
            DisplayStoryBookIds(),
            Divider(),
            SelectStoryBookLevel(),
            Divider(),
            EnterBookTitle(),
            Divider(),
            SelectImage(),
            Divider(),
            SubmitButtonStoryBook()
          ],
        ),
      ),
    );
  }
}

enum PageOrder{
  first, second, third, fouth
}

enum StoryBookLevel{
  one, two, three
}



extension ConvertToInt on StoryBookLevel{
  int convertToInt(){
    switch(this){
      case StoryBookLevel.one:
        return 1;
      case StoryBookLevel.two:
        return 2;
      case StoryBookLevel.three:
        return 3;
    }
  }
}