part of 'auth_cubit.dart';

final class AuthState extends Equatable {
  final bool reload;

  const AuthState({
    this.reload = false,
  });

  @override
  List<Object> get props => [
        reload,
      ];
}
