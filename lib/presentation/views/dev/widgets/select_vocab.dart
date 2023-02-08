import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../get_vocab_data.dart';

class SelectVocab extends StatefulWidget {
  const SelectVocab({super.key});

  @override
  State<SelectVocab> createState() => _SelectVocabState();
}

class _SelectVocabState extends State<SelectVocab> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: () {
      addVocab(context);
    }, child: Text("add Vocab"));
  }
}