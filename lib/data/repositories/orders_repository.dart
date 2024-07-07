import 'package:dyshez_test/data/models/order.dart';
import 'package:dyshez_test/data/providers/orders_provider.dart';
import 'package:get_it/get_it.dart';

class OrdersRepository {
  final locator = GetIt.instance;

  OrdersRepository();

  Future<List<Order>> getOrders() async {
    List<Order> orders = [];
    final response = await locator.get<OrdersProvider>().getOrders();
    Map<String, dynamic>? data = response.data;
    if (data != null) {
      orders = (data["orders"] as List<Map<String, dynamic>>)
          .map((order) => Order.fromJson(order))
          .toList()
          .cast<Order>();
      return orders;
    } else {
      return [];
    }
  }
}
