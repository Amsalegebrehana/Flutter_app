import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:delalo/delalo_app/blocs/blocs.dart';
import 'package:delalo/delalo_app/repository/user_repository/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository})
      : assert(userRepository != null),
        super(UserLoading());
  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserLoad) {
      yield UserLoading();
      try {
        final users = await userRepository.getUserByEmail(event.email);
  
        yield UserLoadSuccess(users);
      } catch (_) {
        yield UserOperationFailure();
      }
    }

    // if (event is UserUpdate) {
    //   try {
    //     await userRepository.updateUser(event.userOnly);
    //     final users = await userRepository.getUsers();
    //     yield UserLoadSuccess(users);
    //   } catch (_) {
    //     yield UserOperationFailure();
    //   }
    // }

    // if (event is UserDelete) {
    //   try {
    //     await userRepository.deleteUser(event.user);
    //     final users = await userRepository.getUsers();
    //     yield UserLoadSuccess(users);
    //   } catch (_) {
    //     yield UserOperationFailure();
    //   }
    // }
  }
}
