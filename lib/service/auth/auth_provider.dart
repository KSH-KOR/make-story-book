// provide FirebaseAuth user

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../models/auth_user.dart';

abstract class AuthProvider {
  Future<AuthUser?> get currentUser;
  Future<void> initialize();
  Future<AuthUser> logIn();
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<void> logOut();
  Future<void> addAuthToDatabase({
    required String name,
    required int birthOrder,
    String? groupId,
  });
  Future<firebase_auth.UserCredential> signInWithGoogle();
  Stream<User?> getAuthStateChanges();
  Future<void> sendEmailVerification();
}
