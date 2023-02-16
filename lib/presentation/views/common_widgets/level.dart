import 'package:flutter/material.dart';
import 'package:my_english_story/presentation/utilities/spacing.dart';

// finish

class Level extends StatelessWidget {
  final double width;
  final double height;
  final int level;
  final Color color;
  const Level(
      {super.key,
      required this.level,
      required this.color,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipOval(
          child: Material(
              color: color, // button color
              child: Column(
                children: [
                  AddVerticalSpace(height * 0.1594),
                  const Text(
                    "Level",
                  ),
                  AddVerticalSpace(height * 0.058),
                  Text(
                    "$level",
                    style: const TextStyle(fontSize: 19),
                  )
                ],
              ))),
    );
  }
}
