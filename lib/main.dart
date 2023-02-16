import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';
import 'presentation/resources/routes_manager.dart';
import 'presentation/views/dev/create_data_into_firebase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitDown,
  ]); //landscapeLeft : 위쪽 세로(portraitUp) 방향에서 시계 방향으로 90도 회전한 형태

  runApp(MaterialApp(
      title: 'My English Story',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.splashRoute,
      home: const CreateDataIntoFirebaseView()));
}
