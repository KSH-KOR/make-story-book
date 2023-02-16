import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_english_story/presentation/resources/assets_manager.dart';
import 'package:my_english_story/presentation/views/common_widgets/word_card.dart';

var sc = const Color(0xffBAEDA6);
var pc = const Color(0xff03B4C3);

class HomepageView extends StatefulWidget {
  const HomepageView({super.key});

  @override
  State<HomepageView> createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView> {
  int step = 0;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight
    ]); //landscapeLeft : 위쪽 세로(portraitUp) 방향에서 시계 방향으로 90도 회전한 형태

    return const Scaffold();
  }
}
