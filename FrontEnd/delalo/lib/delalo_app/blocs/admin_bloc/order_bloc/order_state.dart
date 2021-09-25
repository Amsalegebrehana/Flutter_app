import 'package:equatable/equatable.dart';

class AdminOrderState extends Equatable {
  const AdminOrderState();

  @override
  List<Object> get props => [];
}
class AdminOrderLoading extends AdminOrderState {}

class AdminOrderLoadSuccess extends AdminOrderState {
  final List<dynamic> orders;

  AdminOrderLoadSuccess([this.orders = const[]]);

  @override
  List<Object> get props => [orders];
}

class AdminOrdersLoadSuccess extends AdminOrderState {
  final List<dynamic> orders;

  AdminOrdersLoadSuccess([this.orders = const []]);

  @override
  List<Object> get props => [orders];
}
class AdminOrderOperationFailure extends AdminOrderState {}
