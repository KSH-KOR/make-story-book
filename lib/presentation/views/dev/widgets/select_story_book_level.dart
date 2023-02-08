import 'package:flutter/material.dart';

import '../create_data_into_firebase.dart';
import '../dev_data_provider.dart';

class SelectStoryBookLevel extends StatefulWidget {
  const SelectStoryBookLevel({super.key});

  @override
  State<SelectStoryBookLevel> createState() => _SelectStoryBookLevelState();
}

class _SelectStoryBookLevelState extends State<SelectStoryBookLevel> {
  late final List<StoryBookLevel> levels;
  @override
  void initState() {
    super.initState();
    levels = StoryBookLevel.values;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("select story book level"),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: levels.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return OutlinedButton(
                      style: OutlinedButton.styleFrom(backgroundColor: DevDataProvider().seletedLevel == index ? Colors.blueAccent : Colors.white),
                      onPressed: () => setState(() {
                        DevDataProvider().seletedLevel = index;
                      }),
                      child: Text(levels[index].name, style: TextStyle(color: DevDataProvider().seletedLevel == index ? Colors.white : Colors.blueAccent),),
                    );
                },),
              ],
            );
  }
}