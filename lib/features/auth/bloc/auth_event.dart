part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class EmailChanged extends AuthEvent {
  final String email;

  EmailChanged(this.email);
}
final class UsernameChanged extends AuthEvent {
  final String username;

  UsernameChanged(this.username);
}
final class PasswordChanged extends AuthEvent {
  final String password;

  PasswordChanged(this.password);
}
final class ConfirmPasswordChanged extends AuthEvent {
  final String confirmPassword;

  ConfirmPasswordChanged(this.confirmPassword);
}
final class SignUp extends AuthEvent {}
final class SignIn extends AuthEvent {}
final class SignOut extends AuthEvent {}