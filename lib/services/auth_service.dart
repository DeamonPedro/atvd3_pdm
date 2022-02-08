import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  AuthService._() {
    _auth.authStateChanges().listen((User? user) {
      print(user);
      notifyListeners();
    });
  }
  static final AuthService _authService = AuthService._();

  static AuthService get instance => _authService;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get userID => _auth.currentUser?.uid;

  Future<UserCredential> tryLogin(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
