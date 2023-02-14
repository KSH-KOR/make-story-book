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
import 'package:my_english_story/service/firebase_firestore/story_book_service.dart';
import 'package:uuid/uuid.dart';

import 'dev_data_provider.dart';
import 'widgets/display_added_vocab.dart';
import 'widgets/get_story_book_path.dart';

class CreateDataIntoFirebaseView extends StatefulWidget {
  const CreateDataIntoFirebaseView({super.key});

  @override
  State<CreateDataIntoFirebaseView> createState() =>
      _CreateDataIntoFirebaseViewState();
}

class _CreateDataIntoFirebaseViewState
    extends State<CreateDataIntoFirebaseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [
          CreateStoryPage(),
          CreateStudyPage(),
          CreateQuizPage(),
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
        padding:
            const EdgeInsets.only(top: 100, left: 40, right: 40, bottom: 40),
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
        context: context,
        builder: ((context) {
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
    if (DevDataProvider().storyBookId == null) {
      DevDataProvider().storyBookId = const Uuid().v4();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 100, left: 40, right: 40, bottom: 40),
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

class CreateQuizPage extends StatefulWidget {
  const CreateQuizPage({super.key});

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 100, left: 40, right: 40, bottom: 40),
        child: Column(
          children: const [
            EnterQuisQuestions(),
            SubmitButtonQuiz(),
          ],
        ),
      ),
    );
  }
}

class SubmitButtonQuiz extends StatefulWidget {
  const SubmitButtonQuiz({super.key});

  @override
  State<SubmitButtonQuiz> createState() => _SubmitButtonQuizState();
}

class _SubmitButtonQuizState extends State<SubmitButtonQuiz> {
  late final List<String> quizIds;
  @override
  void initState() {
    super.initState();
    quizIds = List.generate(4, (index) => const Uuid().v4());
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        if (DevDataProvider().quizVocabAnswer.length != 4 ||
            DevDataProvider().quizAnswers.length != 4 ||
            DevDataProvider().quizPrompts.length != 4 ||
            DevDataProvider().quizQuestions.length != 4 ||
            DevDataProvider().quizImageUrl.length != 4 ||
            DevDataProvider().storyBookDocId == null) {
          log("error: fill all information");
          return;
        }
        final List<Future> loading = [];
        for (int i = 0; i < 4; i++) {
          loading.add(StoryBookService.firebase().createNewQuizPage(
            vocabAnswer: DevDataProvider().quizVocabAnswer[i],
            answer: DevDataProvider().quizAnswers[i],
            prompt: DevDataProvider().quizPrompts[i],
            question: DevDataProvider().quizQuestions[i],
            quizImgUrl: DevDataProvider().quizImageUrl[i],
            quizOrder: i + 1,
            storyBookDocId: DevDataProvider().storyBookDocId!,
            quizId: quizIds[i],
          ));
        }
        await Future.wait(loading);
        log("quiz uploaded on firebase successfully!");
        DevDataProvider().clearQuizPageInputs();
      },
      child: Text("add quizs"),
    );
  }
}

class EnterQuisQuestions extends StatefulWidget {
  const EnterQuisQuestions({super.key});

  @override
  State<EnterQuisQuestions> createState() => _EnterQuisQuestionsState();
}

class _EnterQuisQuestionsState extends State<EnterQuisQuestions> {
  late final TextEditingController _questionTextEditingController;

  @override
  void initState() {
    super.initState();
    _questionTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _questionTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("quiz answer list"),
        ListView.builder(
          shrinkWrap: true,
          itemCount: DevDataProvider().quizAnswers.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => _questionTextEditingController.text =
                  DevDataProvider().quizAnswers[index],
              child: Text(DevDataProvider().quizAnswers[index]),
            );
          },
        ),
        const Divider(),
        TextField(
          controller: _questionTextEditingController,
        ),
        const Text("quiz question list"),
        ListView.builder(
          shrinkWrap: true,
          itemCount: DevDataProvider().quizQuestions.length,
          itemBuilder: (context, index) {
            return InkWell(
              onLongPress: () => setState(() {
                DevDataProvider().quizQuestions.removeAt(index);
              }),
              child: Text(DevDataProvider().quizQuestions[index]),
            );
          },
        ),
        OutlinedButton(
          onPressed: () => setState(() {
            DevDataProvider()
                .quizQuestions
                .add(_questionTextEditingController.text);
          }),
          child: const Text("add questions"),
        ),
      ],
    );
  }
}

enum PageOrder { first, second, third, fouth }

enum StoryBookLevel { one, two, three }

extension ConvertToInt on StoryBookLevel {
  int convertToInt() {
    switch (this) {
      case StoryBookLevel.one:
        return 1;
      case StoryBookLevel.two:
        return 2;
      case StoryBookLevel.three:
        return 3;
    }
  }
}
