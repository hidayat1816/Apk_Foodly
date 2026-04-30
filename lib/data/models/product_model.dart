class ProductModel {
  final String name;
  final int price;
  final double star;
  final String image;

  ProductModel({
    required this.name,
    required this.price,
    required this.star,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'] ?? '',
      price: json['price'] ?? 0,

      // 🔥 FIX DI SINI (lebih aman)
      star: (json['star'] ?? 0).toDouble(),

      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "price": price,
      "star": star,
      "image": image,
    };
  }
}