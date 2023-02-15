import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_english_story/presentation/resources/color_manager.dart';
import 'package:my_english_story/presentation/resources/font_manager.dart';

class WordCard extends StatelessWidget {
  double width;
  double height;
  String imagePath;
  String word;
  WordCard(
      {super.key,
      required this.height,
      required this.width,
      required this.imagePath,
      required this.word});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorManager.gray1,
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      width: width,
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 4,
          ),
          Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              width: width * 0.311,
              height: height * 0.84,
              child: Expanded(
                child: SvgPicture.asset(imagePath),
              )),
          Expanded(
              child: Center(
                  child: Text(
            word,
            style: const TextStyle(fontWeight: FontWeightManager.semiBold),
          )))
        ],
      ),
    );
  }
}
