import 'package:flutter/material.dart';

import '../dev_data_provider.dart';

class EnterStoryBookIds extends StatefulWidget {
  const EnterStoryBookIds({super.key});

  @override
  State<EnterStoryBookIds> createState() => _EnterStoryBookIdsState();
}

class _EnterStoryBookIdsState extends State<EnterStoryBookIds> {
  late final TextEditingController _storyBookIdTextEditingController;
  late final TextEditingController _storyBookDocIdTextEditingController;

  @override
  void initState() {
    super.initState();
    _storyBookIdTextEditingController = TextEditingController();
    _storyBookDocIdTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _storyBookIdTextEditingController.dispose();
    _storyBookDocIdTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text("Paste story book id here Or refresh"),
                IconButton(
                    onPressed: () {
                      _storyBookIdTextEditingController.text =
                          DevDataProvider().storyBookId ?? "";
                    },
                    icon: const Icon(Icons.refresh)),
              ],
            ),
            TextField(
              controller: _storyBookIdTextEditingController,
            ),
          ],
        ),
        const Divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text("Paste story book doc id here Or refresh"),
                IconButton(
                  onPressed: () {
                    _storyBookDocIdTextEditingController.text =
                        DevDataProvider().storyBookDocId ?? "";
                  },
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            TextField(
              controller: _storyBookDocIdTextEditingController,
            ),
          ],
        ),
      ],
    );
  }
}
