import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_english_story/presentation/resources/assets_manager.dart';

class CustomProgressBar extends StatefulWidget {
  final int step;
  final double width;
  final double height;

  const CustomProgressBar(
      {super.key,
      required this.step,
      required this.height,
      required this.width});

  @override
  State<CustomProgressBar> createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar> {
  @override
  Widget build(BuildContext context) {
    if (widget.step == 0) {
      return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        height: widget.height,
        width: widget.width,
        child: SvgPicture.asset(ImageAssets.progressStudy),
      );
    } else if (widget.step == 1) {
      return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        height: widget.height,
        width: widget.width,
        child: SvgPicture.asset(ImageAssets.progressQuiz),
      );
    }
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      height: widget.height,
      width: widget.width,
      child: SvgPicture.asset(ImageAssets.progressMakeMine),
    );
  }
}
