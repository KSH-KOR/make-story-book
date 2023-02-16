import 'package:firebase_auth/firebase_auth.dart';


import '../../domain/models/auth_user.dart';
import 'firebase_auth_provider.dart';
import 'auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());
  factory AuthService.mockTesting(AuthProvider p) => AuthService(p);

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      provider.createUser(email: email, password: password);

  @override
  Future<AuthUser?> get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn() =>
      provider.logIn();

  @override
  Future<void> logOut() => provider.logOut();

  
  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<void> addAuthToDatabase({required String name, required int birthOrder, String? groupId}) =>
    provider.addAuthToDatabase(name: name, birthOrder: birthOrder, groupId: groupId);

  @override
  Future<UserCredential> signInWithGoogle() => provider.signInWithGoogle();
  
  @override
  Stream<User?> getAuthStateChanges() => provider.getAuthStateChanges();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();
}
