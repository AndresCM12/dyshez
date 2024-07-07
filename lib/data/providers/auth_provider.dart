import 'dart:async';
import 'dart:developer';

import 'package:dyshez_test/data/models/responses/auth_reponse.dart' as app;
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider {
  final supabaseClient = Supabase.instance.client;

  AuthProvider();

  Future<app.AuthResponse> getUserSession() async {
    Session? session = supabaseClient.auth.currentSession;
    if (session == null) {
      return app.AuthResponse.error("Usuario no autenticado");
    }
    return app.AuthResponse.success(session.toJson());
  }

  Future<app.AuthResponse> signUpWithEmailAndPassword(
    String userName,
    String name,
    String email,
    String phone,
    String password,
  ) async {
    final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          'full_name': name,
          'username': userName,
          "email": email,
          "phone_number": phone
        });

    return response.session == null
        ? app.AuthResponse.error("Error al crear el usuario")
        : app.AuthResponse.success(response.session!.toJson());
  }

  Future<app.AuthResponse> logInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(email: email, password: password);

      return response.session == null
          ? app.AuthResponse.error("Usuario o contraseña incorrectos")
          : app.AuthResponse.success(response.session!.toJson());
    } catch (e) {
      return app.AuthResponse.error("Usuario o contraseña incorrectos");
    }
  }

  Future<app.AuthResponse> restorePassword(String email) async {
    try {
      await supabaseClient.auth.resetPasswordForEmail(email);
      return app.AuthResponse.success(
          {"data": "Correo de recuperación enviado"});
    } catch (e) {
      log(e.toString());
      return app.AuthResponse.error("Correo no encontrado");
    }
  }

  Future<app.AuthResponse> changePassword(String password) async {
    try {
      await supabaseClient.auth.updateUser(UserAttributes(password: password));
      return app.AuthResponse.success({"data": "Contraseña actualizada"});
    } catch (e) {
      log(e.toString());
      return app.AuthResponse.error("Correo no encontrado");
    }
  }

  StreamSubscription<AuthState>? onAuthStateChanged(
      void Function(AuthState state) listener) {
    return supabaseClient.auth.onAuthStateChange.listen(listener);
  }

  void cancelAuthListener(StreamSubscription<AuthState> listener) {
    listener.cancel();
  }

  Future<void> logOut() async {
    await supabaseClient.auth.signOut();
  }
}
