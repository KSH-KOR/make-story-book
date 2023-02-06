import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_english_story/presentation/resources/routes_manager.dart';
import 'package:my_english_story/presentation/views/home/homepage_view.dart';
import 'package:my_english_story/presentation/views/splash/splash_view.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
                    options: DefaultFirebaseOptions.currentPlatform,
                  );
  
  runApp(MaterialApp(
    title: 'My English Story',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    initialRoute: Routes.splashRoute,
    home: const HomepageView(),
  ));
}
