
import 'package:flutter/material.dart';
import 'package:my_english_story/presentation/views/dev/dev_data_provider.dart';

import '../../../../common/enums/vocab_category.dart';

class SelectVocabCategory extends StatefulWidget {
  const SelectVocabCategory({super.key});

  @override
  State<SelectVocabCategory> createState() => _SelectVocabCategoryState();
}

class _SelectVocabCategoryState extends State<SelectVocabCategory> {
  final List<VocabCategory> categories = VocabCategory.values;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("select vocab category"),
        ListView.builder(
          shrinkWrap: true,
          itemCount: categories.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return OutlinedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: DevDataProvider().selectedVocabCategory == index
                      ? Colors.blueAccent
                      : Colors.white),
              onPressed: () => setState(() {
                DevDataProvider().selectedVocabCategory = index;
              }),
              child: Text(
                categories[index].name,
                style: TextStyle(
                    color: DevDataProvider().selectedVocabCategory == index
                        ? Colors.white
                        : Colors.blueAccent),
              ),
            );
          },
        ),
      ],
    );
  }
}
