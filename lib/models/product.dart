// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    Product({
        this.name,
        this.price,
        this.image,
    });

    final String name;
    final int price;
    final String image;

    Product copyWith({
        String name,
        int price,
        String image,
    }) => 
        Product(
            name: name ?? this.name,
            price: price ?? this.price,
            image: image ?? this.image,
        );

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? null : json["price"],
        image: json["image"] == null ? null : json["image"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "image": image == null ? null : image,
    };
}
