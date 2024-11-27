import 'package:flutter/material.dart';
import 'package:gift_planner/models/cart_item.dart';
import 'package:gift_planner/models/product.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = []; // عناصر السلة
  final List<Product> _filteredProducts =
      []; // المنتجات المفلترة بناءً على البحث
  String _searchQuery = '';
  final List<Product> _products = [];

  // نص البحث
  String get searchQuery => _searchQuery;
  List<Product> get products => _products;

  // عدد العناصر في السلة
  int get itemCount {
    return _cartItems.length;
  }

  // إجمالي السعر
  double get totalPrice =>
      _cartItems.fold(0, (total, item) => total + item.totalPrice);

  // المنتجات المفلترة
  List<Product> get filteredProducts => _filteredProducts;

  // السلة
  List<CartItem> get cartItems => _cartItems;

  /// تحديث نص البحث
  void updateSearchQuery(String query, List<Product> products) {
    _searchQuery = query;
    _filterProducts(products); // تطبيق الفلترة مباشرة
    notifyListeners();
  }

  /// دالة الفلترة
  void _filterProducts(List<Product> products) {
    if (_searchQuery.isNotEmpty) {
      final query = RegExp(_searchQuery, caseSensitive: false);
      _filteredProducts
        ..clear()
        ..addAll(products.where((product) =>
            query.hasMatch(product.name) ||
            query.hasMatch(product.description)));
    } else {
      _filteredProducts
        ..clear()
        ..addAll(products);
    }
    notifyListeners();
  }

  /// إضافة منتج إلى السلة
  void addToCart(Product product) {
    final existingItem = _cartItems.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existingItem.quantity > 0) {
      existingItem.quantity++;
    } else {
      _cartItems.add(CartItem(product: product, quantity: 1));
    }
    notifyListeners();
  }

  /// إزالة منتج  منتج من السلة
  void removeFromCart(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
    } else {
      _cartItems.remove(cartItem);
    }
    notifyListeners();
  }

  /// مسح السلة بالكامل
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void removeallFromCart1(CartItem cartItem) {
    _cartItems.remove(cartItem); // حذف المنتج بالكامل بغض النظر عن الكمية
    notifyListeners();
  }
}
