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

      // 💰 handle int / string / null
      price: (json['price'] is int)
          ? json['price']
          : int.tryParse(json['price']?.toString() ?? '0') ?? 0,

      // ⭐ handle int / double / null
      star: (json['star'] is num)
          ? (json['star'] as num).toDouble()
          : double.tryParse(json['star']?.toString() ?? '0') ?? 0.0,

      // 🖼️ image aman
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