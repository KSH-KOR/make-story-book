import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/svg.dart';

import '../../../firebase_options.dart';
import '../../../service/auth/auth_service.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import '../common_widgets/app_logo.dart';
import '../login/login_view.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService.firebase().getAuthStateChanges(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
            if (snapshot.hasData) {
              return FutureBuilder(
                future: Future.wait([
                  Firebase.initializeApp(
                    options: DefaultFirebaseOptions.currentPlatform,
                  ),
                ]),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      return const LoginView();
                    default:
                      return Scaffold(
                        backgroundColor: ColorManager.buttonDisable,
                        body: const Center(
                          child: AppLogo(),
                        ),
                      );
                  }
                },
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Something went Wrong!"),
              );
            } else {
              return const LoginView();
            }
          default:
            return const AppLogo();
        }
      },
    );
  }
}
