import 'package:auto_route/auto_route.dart';
import 'package:dyshez_test/config/app_router.gr.dart';
import 'package:dyshez_test/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());
  final locator = GetIt.instance;

  void initRestorePasswordListener(BuildContext context) {
    locator<AuthRepository>().initAuthStateChangeListener((state) async {
      switch (state.event) {
        case AuthChangeEvent.passwordRecovery:
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text("Navegando a la vista de recuperación de contraseña"),
            ),
          );
          AutoRouter.of(context).push(const ChangePasswordView());
          break;
        default:
          break;
      }
    });
  }

  ///We use this method to verify if the user is authenticated or not on every app start
  ///- If the user is authenticated, we update the state with the user's session and navigate to the Dashboard page
  ///- If the user is not authenticated, we navigate to the login page and show a message
  Future<void> checkUserSession(BuildContext context) async {
    final session = await locator<AuthRepository>().getUserSession();

    if (session.data == null) {
      emit(state.copyWith(isAuthenticated: false));

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(session.errorMessage!),
        ),
      );
      AutoRouter.of(context).replace(const AuthRoute());
      return;
    }
    final sessionObject = Session.fromJson(session.data!);
    emit(state.copyWith(
      isAuthenticated: true,
      session: sessionObject,
    ));
    if (!context.mounted) return;
    AutoRouter.of(context).replace(const DashBoardRoute());
  }

  Future<void> createUserWithEmailAndPassword({
    required String userName,
    required String name,
    required String email,
    required String phone,
    required String password,
    required BuildContext context,
  }) async {
    final response = await locator<AuthRepository>().signUpWithEmailAndPassword(
      userName,
      name,
      email,
      phone,
      password,
    );
    if (response.data == null) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage!),
        ),
      );
      return;
    }

    final sessionObject = Session.fromJson(response.data!);
    emit(state.copyWith(
      isAuthenticated: true,
      session: sessionObject,
    ));

    if (!context.mounted) return;

    AutoRouter.of(context).replaceAll([const DashBoardRoute()]);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Cuenta creada con éxito"),
      ),
    );
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final response = await locator<AuthRepository>().logInWithEmailAndPassword(
      email,
      password,
    );

    if (response.data == null) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage!),
        ),
      );
      return;
    }

    final sessionObject = Session.fromJson(response.data!);
    emit(state.copyWith(
      isAuthenticated: true,
      session: sessionObject,
    ));

    if (!context.mounted) return;

    AutoRouter.of(context).replaceAll([const DashBoardRoute()]);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Inicio de sesión exitoso"),
      ),
    );
  }

  Future<void> restoreAccount({
    required String email,
    required BuildContext context,
  }) async {
    final response = await locator<AuthRepository>().restorePassword(email);
    if (!context.mounted) return;
    if (response.data == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage!),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.data!['data']),
      ),
    );
  }

  Future<void> changePassword(
      {required String password, required BuildContext context}) async {
    final response = await locator<AuthRepository>().changePassword(password);
    if (!context.mounted) return;
    if (response.data == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage!),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.data!['data']),
      ),
    );

    AutoRouter.of(context).replaceAll([const DashBoardRoute()]);
  }

  Future<void> logOut(BuildContext context) async {
    await locator<AuthRepository>().logOut();
    emit(state.copyWith(
      isAuthenticated: false,
      session: null,
    ));

    if (!context.mounted) return;

    AutoRouter.of(context).replaceAll([const AuthRoute()]);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Sesión cerrada con éxito"),
      ),
    );
  }
}
