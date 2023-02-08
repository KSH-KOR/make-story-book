import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_english_story/common/enums/vocab_category.dart';
import 'package:my_english_story/domain/models/vocab.dart';
import 'package:my_english_story/presentation/views/dev/dev_data_provider.dart';
import 'package:my_english_story/presentation/views/dev/widgets/enter_vocab_meaning.dart';
import 'package:uuid/uuid.dart';

import 'widgets/select_image.dart';
import 'widgets/select_vocab_category.dart';

Future<void> addVocab(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SelectVocabCategory(),
                  const EnterVocabMeaning(),
                  const SelectImage(isVocabImage: true),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("cancel")),
                      OutlinedButton(
                        onPressed: () {
                          if (DevDataProvider().selectedVocabCategory == null ||
                              DevDataProvider().vocabMeaning == null ||
                              DevDataProvider().vocabPrompt == null ||
                              DevDataProvider().vocabImagePath == null) {
                            log("error: Enter all information");
                            return;
                          }
                          DevDataProvider().vocabList.add(Vocab(
                                vocabCategory: VocabCategory
                                    .values[DevDataProvider().selectedVocabCategory!],
                                meaning: DevDataProvider().pageDescriptionText!,
                                prompt: DevDataProvider().pagePromptText!,
                                vocabId: const Uuid().v4(),
                                vocabImgRrl: DevDataProvider().vocabImagePath,
                              ));
                          Navigator.of(context).pop();
                        },
                        child: const Text("add vocab"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        
      );
    },
  );
}
