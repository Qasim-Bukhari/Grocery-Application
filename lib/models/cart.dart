import 'package:flutter/material.dart';
import 'product.dart';

class Cart extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;

  double get totalAmount =>
      _items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  void add(Product product) {
    var existingProduct = _items.firstWhere(
      (item) => item.title == product.title,
      orElse: () => Product(
        title: '',
        imageUrl: '',
        quantity: 0,
        price: 0,
      ),
    );

    if (existingProduct.title.isEmpty) {
      _items.add(product);
    } else {
      existingProduct.quantity++;
    }

    notifyListeners();
  }

  void updateQuantity(Product product, int quantity) {
    if (quantity <= 0) {
      _items.remove(product);
    } else {
      product.quantity = quantity;
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
