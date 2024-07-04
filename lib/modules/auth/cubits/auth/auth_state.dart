part of 'auth_cubit.dart';

final class AuthState extends Equatable {
  final bool isAuthenticated;
  final Session? session;

  const AuthState({
    this.isAuthenticated = false,
    this.session,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    Session? session,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      session: session ?? this.session,
    );
  }

  @override
  List<Object?> get props => [
        isAuthenticated,
        session,
      ];
}
