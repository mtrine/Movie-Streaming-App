import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../reponsitory/auth_reponsitory.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthReponsitory _authReponsitory;
  AuthBloc(this._authReponsitory) : super(AuthInitial()) {
    on<EmailChanged>(_emailChanged);
    on<UsernameChanged>(_usernameChanged);
    on<PasswordChanged>(_passwordChanged);
    on<ConfirmPasswordChanged>(_confirmPasswordChanged);
    on<SignUp>(_signUp);
    on<SignIn>(_signIn);
    on<SignOut>(_signOut);
  }
  void _emailChanged(EmailChanged event, Emitter<AuthState> emit) {
    final newValue = event.email;
    final newState = state.copyWith(email: newValue);
    emit(newState);
  }

  void _usernameChanged(UsernameChanged event, Emitter<AuthState> emit) {
    final newValue = event.username;
    final newState = state.copyWith(username: newValue);
    emit(newState);
  }

  void _passwordChanged(PasswordChanged event, Emitter<AuthState> emit) {
    final newValue = event.password;
    final newState = state.copyWith(password: newValue);
    emit(newState);
  }

  void _confirmPasswordChanged(ConfirmPasswordChanged event, Emitter<AuthState> emit) {
    final newValue = event.confirmPassword;
    final newState = state.copyWith(confirmPassword: newValue);
    emit(newState);
  }

  void _signUp(SignUp event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final user = await _authReponsitory.signUp(state.email, state.password);
    if(user!=null){

      await _authReponsitory.createUserInfo(user.id, state.username);
      emit(state.copyWith(status: AuthStatus.success));
    }
    } catch (e) {
      print('Error:$e');
      emit(state.copyWith(status: AuthStatus.error, errorMsg: e.toString()));
    }
  }

  void _signIn(SignIn event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _authReponsitory.signIn(state.email, state.password);
      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, errorMsg: e.toString()));
    }
  }

  void _signOut(SignOut event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _authReponsitory.signOut();
      emit(state.copyWith(status: AuthStatus.success));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, errorMsg: e.toString()));
    }
  }
}
