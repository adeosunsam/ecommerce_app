import 'dart:convert';

GadgetData gadgetDataFromJson(String str) =>
    GadgetData.fromJson(json.decode(str));

String gadgetDataToJson(GadgetData data) => json.encode(data.toJson());

List<Product> productFromJson(String str) => (json.decode(str) as List<dynamic>)
    .map<Product>((product) => Product.fromJson(product))
    .toList();

class GadgetData {
  GadgetData({
    required this.data,
    required this.succeeded,
    required this.message,
    required this.statusCode,
  });

  List<Product> data;
  bool succeeded;
  String message;
  int statusCode;

  factory GadgetData.fromJson(Map<String, dynamic> json) => GadgetData(
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
        succeeded: json["succeeded"],
        message: json["message"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "succeeded": succeeded,
        "message": message,
        "statusCode": statusCode,
      };
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.title,
    required this.price,
    required this.category,
    required this.image,
    required this.description,
  });

  String id, name, title, category, image, description;
  double price;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        title: json["title"],
        price: json["price"].toDouble(),
        category: json["category"],
        image: json["image"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "title": title,
        "price": price,
        "category": category,
        "image": image,
        "description": description,
      };
}

List<CartProduct> gadgetFromJson(String str) =>
    (json.decode(str) as List<dynamic>)
        .map<CartProduct>((product) => CartProduct.fromJson(product))
        .toList();

class CartProduct {
  CartProduct({
    required this.id,
    required this.name,
    required this.title,
    required this.price,
    required this.category,
    required this.image,
    required this.description,
    required this.quantity,
  });

  String id, name, title, category, image, description;
  double price;
  int quantity;

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
        id: json["id"],
        name: json["name"],
        title: json["title"],
        quantity: json["quantity"],
        price: json["price"].toDouble(),
        category: json["category"],
        image: json["image"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "title": title,
        "price": price,
        "quantity": quantity,
        "category": category,
        "image": image,
        "description": description,
      };
}
