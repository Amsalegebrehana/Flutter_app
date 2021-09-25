

import 'package:delalo/delalo_app/data_provider/admin_data/admin_order_jobs_data.dart';
import 'package:delalo/delalo_app/models/orderDetails.dart';

class AdminOrderRepository {
  final AdminOrderDataProvider orderdataProvider;

  AdminOrderRepository({required this.orderdataProvider});

  Future<List<OrderDetails>> getOrders() async {
    print("Inside order repository");
    return await orderdataProvider.getOrders();
  }

  
}