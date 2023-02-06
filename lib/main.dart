import 'package:flutter/material.dart';
import 'package:my_english_story/presentation/resources/routes_manager.dart';

void main() {
  runApp(MaterialApp(
    title: 'My English Story',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    initialRoute: Routes.splashRoute,
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('data')),
    );
  }
}
