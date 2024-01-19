import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class Categories {
  List<Category> categories;

  Categories({
    required this.categories,
  });

  factory Categories.fromRawJson(String str) =>
      Categories.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  String title;
  List<Product> products;

  Category({
    required this.title,
    required this.products,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        title: json["title"],
        products: List<Product>.from(
            json["Products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "Products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  String name;
  double price;
  String photo;
  String description;
  bool viewIsSelected;
  int count;

  Product({
    required this.name,
    required this.price,
    required this.photo,
    required this.description,
    this.viewIsSelected = false,
    this.count = 0,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        price: json["price"]?.toDouble(),
        photo: json["photo"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "photo": photo,
        "description": description,
      };
}

Future<Categories> readCategoriesFromJsonFile(String filePath) async {
  try {
    String contents = await rootBundle.loadString(filePath);
    return Categories.fromRawJson(contents);
  } catch (e) {
    print('Error reading JSON file: $e');
    throw e; // You can handle the error as per your requirement
  }
}
