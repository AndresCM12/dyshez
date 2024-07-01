import 'package:dyshez_test/config/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:equatable/equatable.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());
  final getIt = GetIt.instance;

  // Future<void> redirect() async {
  //   getIt<AppRouter>().push(const )
  // }
}
