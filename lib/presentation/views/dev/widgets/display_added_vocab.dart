import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_english_story/presentation/views/dev/dev_data_provider.dart';

class DisplayAddedVocab extends StatefulWidget {
  const DisplayAddedVocab({super.key});

  @override
  State<DisplayAddedVocab> createState() => _DisplayAddedVocabState();
}

class _DisplayAddedVocabState extends State<DisplayAddedVocab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text("refresh vocab list"),
            IconButton(
                onPressed: () => setState(() {}),
                icon: const Icon(Icons.refresh)),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: DevDataProvider().vocabList.length,
          itemBuilder: (context, index) {
            return Text(DevDataProvider().vocabList[index].meaning);
          },
        ),
      ],
    );
  }
}
