import 'package:bloc/bloc.dart';
import 'package:delalo/delalo_app/models/models.dart';
import 'package:delalo/delalo_app/repository/auth_repository/signupUser_repository.dart';
import 'package:flutter/material.dart';

part 'signupUser_state.dart';
part 'signupUser_event.dart';

class SignupUserBloc extends Bloc<SignupUserEvent, SignupUserState> {
  final SignupUserRepository signupUserRepository;
  SignupUserBloc({required this.signupUserRepository})
      : super(SignupUserInitial());

  @override
  Stream<SignupUserState> mapEventToState(SignupUserEvent event) async* {
    if (event is SignupUserFormSubmitted) {
      yield SignupUserLoading();
      await Future.delayed(Duration(milliseconds: 500));
      try {
        SignupUser userToSignup = SignupUser(
            email: event.email,
            password: event.password,
            phone: event.phone,
            address: event.address,
            firstname: event.firstname,
            lastname: event.lastname,
            role: event.role,
            image: event.image);

        await signupUserRepository.signup(userToSignup);
        yield SignupUserSuccess();
      } catch (e) {
        yield SignupUserFailure(error: e.toString());
      }
    }
  }
}
