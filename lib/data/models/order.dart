import 'package:dyshez_test/data/models/payment_method.dart';
import 'package:dyshez_test/data/models/product.dart';
import 'package:dyshez_test/data/models/restaurant.dart';

class Order {
  final int id;
  final String type;
  final String status;
  final dynamic discount;
  final dynamic tip;
  final dynamic deliveryRate;
  final String address;
  final dynamic reservationCost;
  final dynamic penalty;
  final List<int> productsId;
  final PaymentMethod paymentMethod;
  final Restaurant restaurant;
  final List<Product> products;
  double total = 0.0;
  final String? createdAt;

  Order({
    required this.id,
    required this.type,
    required this.status,
    required this.discount,
    required this.tip,
    required this.deliveryRate,
    required this.address,
    required this.reservationCost,
    required this.penalty,
    required this.productsId,
    required this.paymentMethod,
    required this.restaurant,
    required this.products,
    required this.total,
    this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var order = Order(
      id: json['id'],
      type: json['type'],
      status: json['status'],
      discount: json['discount'] ?? 0.0,
      tip: json['tip'] ?? 0.0,
      deliveryRate: json['delivery_rate'] ?? 0.0,
      address: json['address'] ?? '',
      reservationCost: json['reservation_cost'] ?? 0.0,
      penalty: json['penalty'] ?? 0.0,
      productsId: List<int>.from(json['products_id']),
      paymentMethod: PaymentMethod.fromJson(json['payment_method']),
      restaurant: Restaurant.fromJson(json['restaurant']),
      products: json["products"] != null
          ? List<Product>.from(
              json['products'].map(
                (product) => Product.fromJson(product),
              ),
            )
          : [],
      total: 0.0,
      createdAt: json['created_at'],
    );

    final total = order.products.fold(
        0.0,
        (previousValue, product) =>
            (previousValue + product.price - product.discount));
    order.total = total;
    return order;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'status': status,
      'discount': discount,
      'tip': tip,
      'delivery_rate': deliveryRate,
      'address': address,
      'reservation_cost': reservationCost,
      'penalty': penalty,
      'products_id': productsId,
      'payment_method': paymentMethod.toJson(),
      'restaurant': restaurant.toJson(),
      'products': products.map((product) => product.toJson()).toList(),
      'created_at': createdAt,
    };
  }
}
