import 'package:delalo/delalo_app/models/models.dart';
import 'package:equatable/equatable.dart';

class OrderState extends Equatable {
  const OrderState();
  final String failureMessage = "Failed to load";
  @override
  List<Object> get props => [];
}

class Loading extends OrderState {}

class JobStatusChanged extends OrderState {
  JobStatusChanged();

  @override
  List<Object> get props => [];
}

class StartedWorkingSuccess extends OrderState {
  StartedWorkingSuccess();

  @override
  List<Object> get props => [];
}

class StartedWorkingFailure extends OrderState {
  StartedWorkingFailure();

  @override
  List<Object> get props => [];
}

class PausedWorkingSuccess extends OrderState {
  PausedWorkingSuccess();

  @override
  List<Object> get props => [];
}

class PausedWorkingFailure extends OrderState {
  PausedWorkingFailure();

  @override
  List<Object> get props => [];
}

class CompletedUniqueCodeSuccess extends OrderState {
  CompletedUniqueCodeSuccess();

  @override
  List<Object> get props => [];
}

class CompletedUniqueCodeFailure extends OrderState {
  CompletedUniqueCodeFailure();

  @override
  List<Object> get props => [];
}

class CompleteReviewSuccess extends OrderState {
  CompleteReviewSuccess();

  @override
  List<Object> get props => [];
}

class CompleteReviewFailure extends OrderState {
  CompleteReviewFailure();

  @override
  List<Object> get props => [];
}

class AcceptJobSuccess extends OrderState {
  AcceptJobSuccess();

  @override
  List<Object> get props => [];
}

class AcceptJobFailure extends OrderState {
  AcceptJobFailure();

  @override
  List<Object> get props => [];
}

class DeclineJobSuccess extends OrderState {
  DeclineJobSuccess();

  @override
  List<Object> get props => [];
}

class DeclineJobFailure extends OrderState {
  DeclineJobFailure();

  @override
  List<Object> get props => [];
}

class DeclineOrderSuccess extends OrderState {
  DeclineOrderSuccess();

  @override
  List<Object> get props => [];
}

class DeclineOrderFailure extends OrderState {
  DeclineOrderFailure();

  @override
  List<Object> get props => [];
}

class ActiveOrderDetailSuccess extends OrderState {
  final OrderDetails activeOrderDetail;

  ActiveOrderDetailSuccess(this.activeOrderDetail);

  @override
  List<Object> get props => [activeOrderDetail];
}

class ActiveOrderDetailFailure extends OrderState {}

class ActiveJobSuccess extends OrderState {
  final OrderDetails activeJob;

  ActiveJobSuccess(this.activeJob);

  @override
  List<Object> get props => [activeJob];
}

class ActiveJobFailure extends OrderState {}

class PendingOrdersLoadSuccess extends OrderState {
  final List<dynamic> pendingOrders;

  PendingOrdersLoadSuccess([this.pendingOrders = const []]);

  @override
  List<Object> get props => [pendingOrders];
}

class PendingOrdersLoadFailure extends OrderState {}

class PendingOrdersEmpltyFailure extends OrderState {
  final String message;

  PendingOrdersEmpltyFailure({required this.message});
}

class DeclinedOrdersLoadSuccess extends OrderState {
  final List<dynamic> declinedOrders;

  DeclinedOrdersLoadSuccess([this.declinedOrders = const []]);

  @override
  List<Object> get props => [declinedOrders];
}

class DeclinedOrdersLoadFailure extends OrderState {}

class DeclinedOrdersEmpltyFailure extends OrderState {
  final String message;

  DeclinedOrdersEmpltyFailure({required this.message});
}

class ActiveOrdersLoadSuccess extends OrderState {
  final List<dynamic> activeOrders;

  ActiveOrdersLoadSuccess([this.activeOrders = const []]);

  @override
  List<Object> get props => [activeOrders];
}

class ActiveOrdersLoadFailure extends OrderState {}

class ActiveOrdersEmpltyFailure extends OrderState {
  final String message;

  ActiveOrdersEmpltyFailure({required this.message});
}

class PendingJobsLoadSuccess extends OrderState {
  final List<dynamic> pendingJobs;

  PendingJobsLoadSuccess([this.pendingJobs = const []]);

  @override
  List<Object> get props => [pendingJobs];
}

class PendingJobsLoadFailure extends OrderState {}

class PendingJobsEmpltyFailure extends OrderState {
  final String message;

  PendingJobsEmpltyFailure({required this.message});
}

class CompletedJobsLoadSuccess extends OrderState {
  final List<dynamic> completedJobs;

  CompletedJobsLoadSuccess([this.completedJobs = const []]);

  @override
  List<Object> get props => [completedJobs];
}

class CompletedJobsLoadFailure extends OrderState {}

class CompletedJobsEmpltyFailure extends OrderState {
  final String message;

  CompletedJobsEmpltyFailure({required this.message});
}

class CompletedOrdersLoadSuccess extends OrderState {
  final List<dynamic> completedOrders;

  CompletedOrdersLoadSuccess([this.completedOrders = const []]);

  @override
  List<Object> get props => [completedOrders];
}

class CompletedOrdersLoadFailure extends OrderState {}

class CompletedOrdersEmpltyFailure extends OrderState {
  final String message;

  CompletedOrdersEmpltyFailure({required this.message});
}

class OrderLoadSuccess extends OrderState {
  final Order order;

  OrderLoadSuccess(this.order);

  @override
  List<Object> get props => [order];
}

class OrdersLoadSuccess extends OrderState {
  final List<dynamic> orders;

  OrdersLoadSuccess([this.orders = const []]);

  @override
  List<Object> get props => [orders];
}

class OrderOperationFailure extends OrderState {}
