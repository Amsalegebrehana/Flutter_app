import 'package:delalo/delalo_app/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}

class StartWorking extends OrderEvent {
  final String order_id;
  const StartWorking(this.order_id);

  @override
  List<Object> get props => [];
}

class PauseWorking extends OrderEvent {
  final String order_id;
  const PauseWorking(this.order_id);

  @override
  List<Object> get props => [];
}

class CompleteCode extends OrderEvent {
  final String order_id;

  const CompleteCode(this.order_id);

  @override
  List<Object> get props => [];
}

class CompleteReview extends OrderEvent {
  final String order_id;

  const CompleteReview(this.order_id);

  @override
  List<Object> get props => [];
}

class OrdersLoad extends OrderEvent {
  const OrdersLoad();

  @override
  List<Object> get props => [];
}

class AcceptJob extends OrderEvent {
  final String order_id;
  const AcceptJob(this.order_id);

  @override
  List<Object> get props => [];
}

class DeclineJob extends OrderEvent {
  final String order_id;
  const DeclineJob(this.order_id);

  @override
  List<Object> get props => [];
}

class DeclineOrder extends OrderEvent {
  final String order_id;
  const DeclineOrder(this.order_id);

  @override
  List<Object> get props => [];
}

class CompleteJobsLoad extends OrderEvent {
  final String provider_id;
  const CompleteJobsLoad(this.provider_id);

  @override
  List<Object> get props => [];
}

class ActiveOrdersLoad extends OrderEvent {
  final String seeker_id;
  const ActiveOrdersLoad(this.seeker_id);

  @override
  List<Object> get props => [];
}

class PendingOrdersLoad extends OrderEvent {
  final String seeker_id;
  const PendingOrdersLoad(this.seeker_id);

  @override
  List<Object> get props => [];
}

class ActiveOrderDetailsLoad extends OrderEvent {
  final String order_id;
  const ActiveOrderDetailsLoad(this.order_id);

  @override
  List<Object> get props => [];
}

class DeclinedOrdersLoad extends OrderEvent {
  final String seeker_id;
  const DeclinedOrdersLoad(this.seeker_id);

  @override
  List<Object> get props => [];
}

class CompleteOrdersLoad extends OrderEvent {
  final String seeker_id;
  const CompleteOrdersLoad(this.seeker_id);

  @override
  List<Object> get props => [];
}

class OrderLoad extends OrderEvent {
  final String seeker_id;
  const OrderLoad(this.seeker_id);

  @override
  List<Object> get props => [];
}

class ProviderJobStatus extends OrderEvent {
  final String provider_id;
  const ProviderJobStatus(this.provider_id);

  @override
  List<Object> get props => [];
}

class OrderCreate extends OrderEvent {
  final Order order;

  const OrderCreate(this.order);

  @override
  List<Object> get props => [order];

  @override
  String toString() => 'Order Created {order: $order}';
}

class OrderUpdate extends OrderEvent {
  final Order order;

  const OrderUpdate(this.order);

  @override
  List<Object> get props => [order];

  @override
  String toString() => 'Order Updated {order: $order}';
}

class OrderDelete extends OrderEvent {
  final Order order;

  const OrderDelete(this.order);

  @override
  List<Object> get props => [order];

  @override
  toString() => 'Order Deleted {order: $order}';
}
