
import 'package:flutter/material.dart';
import 'package:my_english_story/presentation/views/dev/dev_data_provider.dart';
import 'package:uuid/uuid.dart';

class EnterPageDesAndPrompt extends StatefulWidget {
  const EnterPageDesAndPrompt({super.key});

  @override
  State<EnterPageDesAndPrompt> createState() => _EnterPageDesAndPromptState();
}

class _EnterPageDesAndPromptState extends State<EnterPageDesAndPrompt> {
  late final TextEditingController _pageDescriptionTextEditingController;
  late final TextEditingController _pagePromptTextEditingController;

  @override
  void initState() {
    super.initState();
    _pageDescriptionTextEditingController = TextEditingController();
    _pagePromptTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageDescriptionTextEditingController.dispose();
    _pagePromptTextEditingController.dispose();
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
            const Text("Enter page description"),
            TextField(
              controller: _pageDescriptionTextEditingController,
              onChanged: (value) {
                DevDataProvider().pageDescriptionText = value;
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
              controller: _pagePromptTextEditingController,
              onChanged: (value) {
                DevDataProvider().pagePromptText = value;
              },
            ),
          ],
        ),
      ],
    );
  }
}
