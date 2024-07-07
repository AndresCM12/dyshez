class Restaurant {
  final int id;
  final String name;
  final String address;
  final String featuredImage;

  Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.featuredImage,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      featuredImage: json['featured_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'featured_image': featuredImage,
    };
  }
}
