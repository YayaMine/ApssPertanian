class LikedProduct {
  final int? id;
  final String name;
  final String price;
  final String imagePath;

  LikedProduct({
    this.id,
    required this.name,
    required this.price,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'price': price, 'imagePath': imagePath};
  }

  factory LikedProduct.fromMap(Map<String, dynamic> map) {
    return LikedProduct(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      imagePath: map['imagePath'],
    );
  }
}
