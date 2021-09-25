import 'package:delalo/delalo_app/repository/admin_repository/admin_order_jobs_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_event.dart';
import 'order_state.dart';


class AdminOrderBloc extends Bloc<AdminOrderEvent, AdminOrderState> {
  final AdminOrderRepository adminOrderRepository;

  AdminOrderBloc({required this.adminOrderRepository}) : super(AdminOrderLoading());

  @override
  Stream<AdminOrderState> mapEventToState(AdminOrderEvent event) async* {
    if (event is AdminOrdersLoad) {
      yield AdminOrderLoading();
      try {
        final orders = await adminOrderRepository.getOrders();
        
        yield AdminOrdersLoadSuccess(orders);
      } catch (_) {
        yield AdminOrderOperationFailure();
      }
    }
  }
}