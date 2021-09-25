import 'package:delalo/delalo_app/blocs/blocs.dart';
import 'package:delalo/delalo_app/models/models.dart';
import 'package:delalo/delalo_app/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository orderRepository;

  OrderBloc({required this.orderRepository})
      : assert(orderRepository != null),
        super(Loading());

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is StartWorking) {
      yield Loading();
      try {
        await orderRepository.updateOrder(event.order_id, "started");
        yield StartedWorkingSuccess();
      } catch (_) {
        yield StartedWorkingFailure();
      }
    }
    if (event is PauseWorking) {
      yield Loading();
      try {
        await orderRepository.updateOrder(event.order_id, "paused");
        yield PausedWorkingSuccess();
      } catch (_) {
        yield PausedWorkingFailure();
      }
    }

    if (event is CompleteCode) {
      try {
        print("trying");
        dynamic res =
            await orderRepository.updateOrder(event.order_id, "finished");
        print("ssss$res");
        yield CompletedUniqueCodeSuccess();
      } catch (err) {
        print(err);
        yield CompletedUniqueCodeFailure();
      }
    }

    // if (event is CompleteReview) {
    //   try {
    //     dynamic currentOrder =
    //         await orderRepository.(event.order_id, "finished");

    //     yield CompleteReviewSuccess();
    //   } catch (_) {
    //     yield CompleteReviewFailure();
    //   }
    // }

    if (event is AcceptJob) {
      yield Loading();
      try {
        final resStatus =
            await orderRepository.updateJobStatus(event.order_id, "active");

        if (resStatus == 201) {
          print("job accepted");
          yield AcceptJobSuccess();
        } else {
          yield AcceptJobFailure();
        }

        // yield ActiveJobSuccess(job);
      } catch (_) {
        yield ActiveJobFailure();
      }
    }
    if (event is DeclineJob) {
      yield Loading();
      try {
        final resStatus =
            await orderRepository.updateJobStatus(event.order_id, "declined");

        if (resStatus == 201) {
          yield DeclineJobSuccess();
        } else {
          yield DeclineJobFailure();
        }

        // yield ActiveJobSuccess(job);
      } catch (_) {
        yield DeclineJobFailure();
      }
    }
    if (event is DeclineOrder) {
      yield Loading();
      try {
        final resStatus = await orderRepository.deleteOrder(event.order_id);

        if (resStatus == 200) {
          yield DeclineOrderSuccess();
        } else {
          yield DeclineOrderFailure();
        }

        // yield ActiveJobSuccess(job);
      } catch (_) {
        yield DeclineJobFailure();
      }
    }

    if (event is ProviderJobStatus) {
      yield Loading();
      try {
        final activeJob = await orderRepository.getActiveJob(event.provider_id);

        if (activeJob is OrderDetails) {
          yield ActiveJobSuccess(activeJob);
        } else {
          try {
            final pendingJobs =
                await orderRepository.getPendingJobs(event.provider_id);
            if (pendingJobs[0] == "No Pending Jobs") {
              yield PendingJobsEmpltyFailure(message: "No Pending Jobs");
            } else {
              yield PendingJobsLoadSuccess(pendingJobs);
            }
          } catch (err) {
            yield PendingJobsLoadFailure();
          }
        }

        // yield ActiveJobSuccess(job);
      } catch (err) {
        yield ActiveJobFailure();
      }
    }
    if (event is CompleteOrdersLoad) {
      yield Loading();
      try {
        final completedOrders =
            await orderRepository.getCompletedOrders(event.seeker_id);
        if (completedOrders[0] == "No History yet") {
          yield CompletedOrdersEmpltyFailure(message: "No Hisotry Yet");
        } else {
          yield CompletedOrdersLoadSuccess(completedOrders);
        }
      } catch (err) {
        print("s$err");
        yield CompletedOrdersLoadFailure();
      }
    }
    if (event is CompleteJobsLoad) {
      yield Loading();
      try {
        final completedJobs =
            await orderRepository.getCompletedJobs(event.provider_id);
        if (completedJobs[0] == "No History yet") {
          yield CompletedJobsEmpltyFailure(message: "No Hisotry Yet");
        } else {
          yield CompletedJobsLoadSuccess(completedJobs);
        }
      } catch (err) {
        print("s$err");
        yield CompletedJobsLoadFailure();
      }
    }
    if (event is PendingOrdersLoad) {
      yield Loading();
      try {
        final pendingOrders =
            await orderRepository.getPendingOrders(event.seeker_id);
        if (pendingOrders[0] == "No Pending Orders") {
          yield PendingOrdersEmpltyFailure(message: "No Pending Orders");
        } else {
          yield PendingOrdersLoadSuccess(pendingOrders);
        }
      } catch (err) {
        print("s$err");
        yield PendingOrdersLoadFailure();
      }
    }

    if (event is DeclinedOrdersLoad) {
      yield Loading();
      try {
        final declinedOrders =
            await orderRepository.getDeclinedOrders(event.seeker_id);
        if (declinedOrders[0] == "No Declined Orders") {
          yield DeclinedOrdersEmpltyFailure(message: "No Declined Orders");
        } else {
          yield DeclinedOrdersLoadSuccess(declinedOrders);
        }
      } catch (err) {
        print("s$err");
        yield DeclinedOrdersLoadFailure();
      }
    }

    if (event is ActiveOrdersLoad) {
      yield Loading();
      try {
        final activeOrders =
            await orderRepository.getActiveOrders(event.seeker_id);
        if (activeOrders[0] == "No Active Orders") {
          yield ActiveOrdersEmpltyFailure(message: "No Active Orders");
        } else {
          yield ActiveOrdersLoadSuccess(activeOrders);
        }
      } catch (err) {
        print("s$err");
        yield ActiveOrdersLoadFailure();
      }
    }

    if (event is ActiveOrderDetailsLoad) {
      yield Loading();

      try {
        final activeOrderDetail =
            await orderRepository.getSingleOrder(event.order_id);

        yield ActiveOrderDetailSuccess(activeOrderDetail);
      } catch (err) {
        print("s$err");
        yield ActiveOrderDetailFailure();
      }
    }

    if (event is OrdersLoad) {
      yield Loading();
      try {
        final orders = await orderRepository.getOrders();

        yield OrdersLoadSuccess(orders);
      } catch (_) {
        yield OrderOperationFailure();
      }
    }
    if (event is OrderLoad) {
      yield Loading();
      try {
        final order = await orderRepository.getOrderById(event.seeker_id);

        yield OrderLoadSuccess(order);
      } catch (_) {
        yield OrderOperationFailure();
      }
    }

    if (event is OrderCreate) {
      try {
        await orderRepository.createOrder(event.order);
        final orders = await orderRepository.getOrders();
        yield OrdersLoadSuccess(orders);
      } catch (_) {
        yield OrderOperationFailure();
      }
    }

    // if (event is OrderUpdate) {
    //   try {
    //     await orderRepository.updateOrder(event.order_id);
    //     final orders = await orderRepository.getOrders();
    //     yield OrdersLoadSuccess(orders);
    //   } catch (_) {
    //     yield OrderOperationFailure();
    //   }
    // }

    // if (event is OrderDelete) {
    //   try {
    //     await orderRepository.deleteOrder(event.order_id);
    //     final orders = await orderRepository.getOrders();
    //     yield OrdersLoadSuccess(orders);
    //   } catch (_) {
    //     yield OrderOperationFailure();
    //   }
    // }
  }
}
