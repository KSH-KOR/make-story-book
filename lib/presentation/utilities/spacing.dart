import 'package:flutter/cupertino.dart';

class AddVerticalSpace extends StatelessWidget {
  const AddVerticalSpace(this.size, {super.key});
  final double size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size,);
  }
}

class AddHorizontalSpace extends StatelessWidget {
  const AddHorizontalSpace(this.size, {super.key});
  final double size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size,);
  }
}