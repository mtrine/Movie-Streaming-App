part of 'auth_bloc.dart';

enum AuthStatus { initial,loading, success, error }

final class AuthState {
  late final String email;
  late final String username;
  late final String password;
  late final String confirmPassword;
  late final AuthStatus status;
  late String? errorMsg;
  late BuildContext context;

  AuthState({

    this.email = '',
    this.username = '',
    this.password = '',
    this.confirmPassword = '',
    this.status = AuthStatus.initial,
    this.errorMsg,
  });
  AuthState copyWith({
    String? email,
    String? username,
    String? password,
    String? confirmPassword,
    AuthStatus? status,
    String? errorMsg,
  }) {
    return AuthState(
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

final class AuthInitial extends AuthState {}
