
import 'package:flutter/material.dart';
import 'package:my_english_story/presentation/views/dev/dev_data_provider.dart';
import 'package:uuid/uuid.dart';

class EnterVocabMeaning extends StatefulWidget {
  const EnterVocabMeaning({super.key});

  @override
  State<EnterVocabMeaning> createState() => _EnterVocabMeaningState();
}

class _EnterVocabMeaningState extends State<EnterVocabMeaning> {
  late final TextEditingController _vocabMeaningTextEditingController;
  late final TextEditingController _vocabPromptTextEditingController;

  @override
  void initState() {
    super.initState();
    _vocabMeaningTextEditingController = TextEditingController();
    _vocabPromptTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _vocabMeaningTextEditingController.dispose();
    _vocabPromptTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Enter vocab meaning"),
            TextField(
              controller: _vocabMeaningTextEditingController,
              onChanged: (value) {
                DevDataProvider().vocabMeaning = value;
              },
            ),
          ],
        ),
        const Divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Enter vocab prompt"),
            TextField(
              controller: _vocabPromptTextEditingController,
              onChanged: (value) {
                DevDataProvider().vocabPrompt = value;
              },
            ),
          ],
        ),
      ],
    );
  }
}
