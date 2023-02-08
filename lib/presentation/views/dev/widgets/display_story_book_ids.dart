import 'package:flutter/material.dart';

import '../dev_data_provider.dart';

class DisplayStoryBookIds extends StatefulWidget {
  const DisplayStoryBookIds({super.key});

  @override
  State<DisplayStoryBookIds> createState() => _DisplayStoryBookIdsState();
}

class _DisplayStoryBookIdsState extends State<DisplayStoryBookIds> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("stoty book id: "),
            Flexible(child: SelectableText(DevDataProvider().storyBookId!)),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("stoty book doc id: "),
            Flexible(
                child:
                    SelectableText(DevDataProvider().storyBookDocId ?? "none")),
          ],
        ),
      ],
    );
  }
}
