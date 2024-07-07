class Product {
  final int id;
  final String status;
  final String name;
  final double price;
  final double discount;

  Product({
    required this.id,
    required this.status,
    required this.name,
    required this.price,
    required this.discount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      status: json['status'],
      name: json['name'],
      price: json['price'],
      discount: json['discount'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'name': name,
      'price': price,
      'discount': discount,
    };
  }
}
