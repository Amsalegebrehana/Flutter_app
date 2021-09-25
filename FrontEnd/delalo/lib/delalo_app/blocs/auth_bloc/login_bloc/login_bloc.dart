import 'package:bloc/bloc.dart';
import 'package:delalo/delalo_app/models/auth/login.dart';
import 'package:delalo/delalo_app/repository/auth_repository/login_repository.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  LoginBloc({required this.loginRepository}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginFormSubmitted) {
      yield LoginLoading();

      try {
        Login userLogger = Login(email: event.email, password: event.password);

        String role = await loginRepository.login(userLogger);
        yield LoginSuccess(role);

      } catch (e) {
        yield LoginFailure(error: e.toString());
      }
    }
  }
}
