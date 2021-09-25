import 'package:delalo/delalo_app/data_provider/data_provider.dart';
import 'package:delalo/delalo_app/models/models.dart';

class OrderRepository {
  final OrderDataProvider dataProvider;

  OrderRepository({required this.dataProvider}) : assert(dataProvider != null);

  Future<Order> createOrder(Order order) async {
    return await dataProvider.createOrder(order);
  }

  Future<List<Order>> getOrders() async {
    return await dataProvider.getOrders();
  }

  Future<Order> getOrderById(String seeker_id) async {
    return await dataProvider.getOrderById(seeker_id);
  }

  Future<dynamic> deleteOrder(String order_id) async {
    return await dataProvider.deleteOrder(order_id);
  }

  Future<dynamic> updateOrder(String order_id, String progress) async {
    return await dataProvider.updateOrder(order_id, progress);
  }

  Future<List<OrderDetails>> getAllJobs(User provider) async {
    return await dataProvider.getAllJobs(provider);
  }

  Future<dynamic> updateJobStatus(String order_id, String status) async {
    return await dataProvider.updateJobStatus(order_id, status);
  }

  Future<dynamic> getActiveJob(String provider_id) async {
    return await dataProvider.getActiveJob(provider_id);
  }

  Future<List<dynamic>> getPendingJobs(String provider_id) async {
    return await dataProvider.getPendingJobs(provider_id);
  }

  Future<List<dynamic>> getDeclinedJobs(String provider_id) async {
    return await dataProvider.getDeclinedJobs(provider_id);
  }

  Future<List<dynamic>> getCompletedJobs(String provider_id) async {
    return await dataProvider.getCompletedJobs(provider_id);
  }

  Future<dynamic> getActiveOrders(String seeker_id) async {
    return await dataProvider.getActiveOrders(seeker_id);
  }

  Future<List<dynamic>> getPendingOrders(String seeker_id) async {
    return await dataProvider.getPendingOrders(seeker_id);
  }

  Future<List<dynamic>> getDeclinedOrders(String seeker_id) async {
    return await dataProvider.getDeclinedOrders(seeker_id);
  }

  Future<List<dynamic>> getCompletedOrders(String seeker_id) async {
    return await dataProvider.getCompletedOrders(seeker_id);
  }

  Future<dynamic> getSingleOrder(String order_id) async {
    return await dataProvider.getSingleOrder(order_id);
  }
}
