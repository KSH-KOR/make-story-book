import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_english_story/presentation/resources/styles_manager.dart';
import 'package:my_english_story/presentation/utilities/spacing.dart';

enum Navigate { next, prev, confirm, redraw }

dynamic doesntReturn() {
  print(errorTextConfiguration);
}

class NavigateButton extends StatefulWidget {
  double width;
  Navigate step;

  double height;
  Color buttonColor;
  String buttonName;
  Color textColor;
  IconData buttonIcon;

  NavigateButton(
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
    if (widget.step == Navigate.next) {
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
    } //next Step Button
    else if (widget.step == Navigate.prev) {
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
    } else if (widget.step == Navigate.confirm) {
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
    } else if (widget.step == Navigate.redraw) {
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
    return doesntReturn();
  }
}
