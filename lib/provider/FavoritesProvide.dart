import 'package:flutter/material.dart';
import 'package:gift_planner/models/product.dart'; // تأكد من استيراد الكلاس الخاص بالمنتج

class FavoriteProvider with ChangeNotifier {
  final List<Product> _favoriteItems = [];

  List<Product> get favoriteItems => _favoriteItems;

  void toggleFavorite(Product product) {
    if (_favoriteItems.contains(product)) {
      _favoriteItems.remove(product);
      // ignore: avoid_print
      print('${product.name} removed from favorites');
    } else {
      _favoriteItems.add(product);
      // ignore: avoid_print
      print('${product.name} added to favorites');
    }
    notifyListeners(); // لتحديث الـ UI
  }
}
