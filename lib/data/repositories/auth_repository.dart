import 'dart:async';
import 'dart:developer';

import 'package:dyshez_test/data/models/responses/auth_reponse.dart';
import 'package:dyshez_test/data/providers/auth_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class AuthRepository {
  final locator = GetIt.instance;
  StreamSubscription<supabase.AuthState>? _authSubscription;

  AuthRepository();

  void initAuthStateChangeListener(void Function(supabase.AuthState) callBack) {
    if (_authSubscription != null) return;

    _authSubscription =
        locator.get<AuthProvider>().onAuthStateChanged(callBack)!;
  }

  void cancelAuthStateChangeListener() {
    log("Canceling AuthState listener ${_authSubscription.toString()}");
    locator.get<AuthProvider>().cancelAuthListener(_authSubscription!);
  }

  Future<AuthResponse> getUserSession() async {
    final authResponse = locator.get<AuthProvider>().getUserSession();
    return authResponse;
  }

  Future<AuthResponse> signUpWithEmailAndPassword(
    String userName,
    String name,
    String email,
    String phone,
    String password,
  ) async {
    final authResponse = locator.get<AuthProvider>().signUpWithEmailAndPassword(
          userName,
          name,
          email,
          phone,
          password,
        );

    return authResponse;
  }

  Future<AuthResponse> logInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final authResponse =
        locator.get<AuthProvider>().logInWithEmailAndPassword(email, password);

    return authResponse;
  }

  Future<AuthResponse> restorePassword(String email) async {
    return await locator.get<AuthProvider>().restorePassword(email);
  }

  Future<AuthResponse> changePassword(String password) async {
    return await locator.get<AuthProvider>().changePassword(password);
  }

  Future<void> logOut() async {
    await locator.get<AuthProvider>().logOut();
  }
}
