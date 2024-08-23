
class Product {
  String id;
  String name;
  String stock;
  String price;
  String imageurl;

  Product({
    required this.id,
    required this.name,
    required this.stock,
    required this.price,
    required this.imageurl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      stock: json['stock'],
      price: json['price'],
      imageurl: json['imageurl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'stock': stock,
      'price': price,
      'imageurl': imageurl,
    };
  }
}
