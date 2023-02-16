import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_english_story/presentation/resources/styles_manager.dart';
import 'package:my_english_story/presentation/utilities/spacing.dart';

enum Navigate { next, prev, confirm, redraw }

class NavigateButton extends StatefulWidget {
  final double width;
  final Navigate step;

  final double height;
  final Color buttonColor;
  final String buttonName;
  final Color textColor;
  final IconData buttonIcon;

  const NavigateButton(
      {super.key,
      required this.step,
      required this.buttonIcon,
      required this.textColor,
      required this.buttonName,
      required this.height,
      required this.width,
      required this.buttonColor});

  @override
  State<NavigateButton> createState() => _NavigateButtonState();
}

class _NavigateButtonState extends State<NavigateButton> {
  @override
  Widget build(BuildContext context) {
    switch (widget.step) {
      case Navigate.next:
        return InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                color: widget.buttonColor,
                borderRadius: const BorderRadius.all(Radius.circular(16))),
            width: widget.width,
            height: widget.height,
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: Row(
                children: [
                  Text(
                    widget.buttonName,
                    style: getBoldStyle(color: widget.textColor),
                  ),
                  const Spacer(),
                  Icon(
                    widget.buttonIcon,
                    color: widget.textColor,
                  )
                ],
              ),
            ),
          ),
        );
      case Navigate.prev:
        return InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                color: widget.buttonColor,
                borderRadius: const BorderRadius.all(Radius.circular(16))),
            width: widget.width,
            height: widget.height,
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: Row(
                children: [
                  Icon(
                    widget.buttonIcon,
                    color: widget.textColor,
                  ),
                  const Spacer(),
                  Text(
                    widget.buttonName,
                    style: getBoldStyle(color: widget.textColor),
                  ),
                ],
              ),
            ),
          ),
        );
      case Navigate.confirm:
        return InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                color: widget.buttonColor,
                borderRadius: const BorderRadius.all(Radius.circular(16))),
            width: widget.width,
            height: widget.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.buttonIcon,
                  color: widget.textColor,
                ),
                const AddHorizontalSpace(8),
                Text(
                  widget.buttonName,
                  style: getBoldStyle(color: widget.textColor),
                ),
              ],
            ),
          ),
        );
      case Navigate.redraw:
        return InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
                color: widget.buttonColor,
                borderRadius: const BorderRadius.all(Radius.circular(16))),
            width: widget.width,
            height: widget.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.buttonIcon,
                  color: widget.textColor,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  widget.buttonName,
                  style: getBoldStyle(color: widget.textColor),
                ),
              ],
            ),
          ),
        );
    }
  }
}
