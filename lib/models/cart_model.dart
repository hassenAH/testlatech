import 'package:TestLaTech/models/categorie.dart';
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  // list of items on sale

  // list of cart items
  List<Product> _cartItems = [];

  get cartItems => _cartItems;

  // add item to cart
  void addItemToCart(Product p) {
    _cartItems.add(p);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(Product p) {
    _cartItems.remove(p);
    notifyListeners();
  }

  // calculate total price
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice += cartItems[i].price;
    }
    return totalPrice.toStringAsFixed(3);
  }
}
