import 'dart:developer';

import 'package:dyshez_test/data/models/responses/order_reponse.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrdersProvider {
  final supabaseClient = Supabase.instance.client;

  OrdersProvider();

  Future<OrderResponse> getOrders(
    String filterByDate,
    String filterByType,
    String filterByStatus,
  ) async {
    try {
      List<Map<String, dynamic>> response = [];

      //We apply the filters to the orders
      List<Map<String, dynamic>> ordersResponse =
          await supabaseClient.from('orders').select("*");

      if (filterByDate == "desc" && ordersResponse.isNotEmpty) {
        ordersResponse
            .sort((a, b) => a["created_at"].compareTo(b["created_at"]));
      } else {
        ordersResponse
            .sort((a, b) => b["created_at"].compareTo(a["created_at"]));
      }

      if (filterByType != "all" && ordersResponse.isNotEmpty) {
        ordersResponse = ordersResponse
            .where((element) => element["type"] == filterByType)
            .toList();
      }

      if (filterByStatus != "all" && ordersResponse.isNotEmpty) {
        ordersResponse = ordersResponse
            .where((element) => element["status"] == filterByStatus)
            .toList();
      }

      //Then we obtain the products of each products_id in the ordersResponse
      await Future.forEach(ordersResponse, (rawOrder) async {
        List<Map<String, dynamic>> products = [];

        Map<String, dynamic> paymentMethod = await supabaseClient
            .from('payment_methods')
            .select("*")
            .eq("id", rawOrder["payment_method_id"])
            .single();

        Map<String, dynamic> restaurant = await supabaseClient
            .from('restaurants')
            .select("*")
            .eq("id", rawOrder["restaurant_id"])
            .single();

        await Future.forEach(rawOrder["products_id"] as List<dynamic>,
            (productId) async {
          if (productId == null) return;

          final productResponse =
              await supabaseClient.from('products').select("*");

          if (productResponse.isEmpty) return;
          products.add(
            productResponse.firstWhere((element) => element["id"] == productId),
          );
        });

        response.add({
          ...rawOrder,
          "products": products,
          "restaurant": restaurant,
          "payment_method": paymentMethod,
        });
      });

      return OrderResponse.success({"orders": response});
    } catch (e) {
      log("Error al obtener las ordenes: $e");
      return OrderResponse.error("Error al obtener las ordenes");
    }
  }
}
