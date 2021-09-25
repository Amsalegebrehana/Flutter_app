import 'package:delalo/delalo_app/models/order_jobs.dart';
import 'package:equatable/equatable.dart';

abstract class AdminOrderEvent extends Equatable {
  const AdminOrderEvent();
}

class AdminOrdersLoad extends AdminOrderEvent {
  const AdminOrdersLoad();

  @override
  List<Object> get props => [];
}

class AdminOrderLoad extends AdminOrderEvent {
  final String seeker_id;
  const AdminOrderLoad(this.seeker_id);

  @override
  List<Object> get props => [];
}

class AdminOrderCreate extends AdminOrderEvent {
  final Order order;

  const AdminOrderCreate(this.order);

  @override
  List<Object> get props => [order];

  @override
  String toString() => 'Order Created {order: $order}';
}

class AdminOrderUpdate extends AdminOrderEvent {
  final Order order;

  const AdminOrderUpdate(this.order);

  @override
  List<Object> get props => [order];

  @override
  String toString() => 'Order Updated {order: $order}';
}

class AdminOrderDelete extends AdminOrderEvent {
  final Order order;

  const AdminOrderDelete(this.order);

  @override
  List<Object> get props => [order];

  @override
  toString() => 'Order Deleted {order: $order}';
}