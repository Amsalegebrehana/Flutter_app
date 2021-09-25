import 'package:equatable/equatable.dart';
import 'package:delalo/delalo_app/models/models.dart';
import 'package:delalo/delalo_app/models/user_only.dart';
import 'package:delalo/delalo_app/blocs/user/user_bloc/user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserLoad extends UserEvent {
  final String email;
  const UserLoad({required this.email});

  @override
  List<Object> get props => [];
}

class UserUpdate extends UserEvent {
  final Users userOnly;

  const UserUpdate(this.userOnly);

  @override
  List<Object> get props => [userOnly];

  @override
  String toString() => 'User Updated {user: $userOnly}';
}

class UserDelete extends UserEvent {
  final User user;

  const UserDelete(this.user);

  @override
  List<Object> get props => [user];

  @override
  toString() => 'User Deleted {user: $user}';
}
