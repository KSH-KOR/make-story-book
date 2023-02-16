import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_english_story/presentation/resources/assets_manager.dart';
import 'package:my_english_story/presentation/utilities/spacing.dart';

// finish

class NavigationRail extends StatefulWidget {
  double height;
  double width;
  NavigationRail({super.key, required this.height, required this.width});

  @override
  State<NavigationRail> createState() => _NavigationRailState();
}

class _NavigationRailState extends State<NavigationRail> {
  bool isLibrarySelected = true;
  bool isMyLibrarySelected = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: (widget.height * 2) + 16,
      child: Row(
        children: [
          Column(
            children: [
              InkWell(
                  //Library
                  onTap: () {
                    setState(() {
                      if (isLibrarySelected == false) {
                        isLibrarySelected = true;
                        isMyLibrarySelected = false;
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isLibrarySelected
                          ? const Color(0xff03B4C3)
                          : const Color(0xff056C75),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                      ),
                    ),
                    width: widget.width,
                    height: widget.height,
                    child: SvgPicture.asset(ImageAssets.library),
                  )),
              const AddVerticalSpace(16),
              InkWell(
                  // MyLibrary
                  onTap: () {
                    setState(() {
                      if (isMyLibrarySelected == false) {
                        isMyLibrarySelected = true;
                        isLibrarySelected = false;
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isMyLibrarySelected
                          ? const Color(0xff03B4C3)
                          : const Color(0xff056C75),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                      ),
                    ),
                    width: widget.width,
                    height: widget.height,
                    child: SvgPicture.asset(ImageAssets.myLibrary),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
