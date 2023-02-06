import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/assets_manager.dart';
import '../../resources/values_manager.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = AppSize.s100});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
            ImageAssets.appLogo,
            width: size,
            height: size,
    );
  }
}