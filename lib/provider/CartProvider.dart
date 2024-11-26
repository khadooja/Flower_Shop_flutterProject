import 'package:flutter/material.dart';
import 'package:gift_planner/models/cart_item.dart';
import 'package:gift_planner/models/product.dart';
// تعديل المسار حسب ملف عنصر السلة الخاص بك

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];
  final List<Product> _products = []; // قائمة المنتجات الكاملة
  // لتخزين نص البحث

  List<Product> loadDefualtProductd() {
    // إضافة بعض المنتجات افتراضيًا عند البداية
    return ([
      Product(
          id: 1,
          name: "Rose",
          price: "20",
          image: "images/1.jpg",
          description:
              'Known for its classic beauty and fragrance, roses are symbols of love and passion. They come in many colors, each with its own meaning.',
          title: 'classic beauty and fragrance'),
      Product(
          id: 2,
          name: "Tulip",
          price: "30",
          image: "images/7.jpg",
          description:
              'Tulips are vibrant and come in almost every color. They are often associated with spring and symbolize perfect love.',
          title: 'Tulips are vibrant and come in almost every color'),
      Product(
          id: 3,
          name: "Lily",
          price: "25",
          image: "images/3.jpg",
          description:
              'Lilies are elegant flowers with a strong fragrance. They are often found in white and symbolize purity and refined beauty.',
          title: 'Lilies are elegant flowers with a strong fragrance'),
      Product(
          id: 4,
          name: "Orchid",
          price: "20",
          image: "images/4.jpg",
          description:
              'Sunflowers are bright and cheerful, always facing the sun. They symbolize adoration, loyalty, and longevity.',
          title: 'Sunflowers are bright and cheerful'),
      Product(
          id: 5,
          name: "Sunflower",
          price: "25",
          image: "images/5.jpg",
          description:
              'Sunflowers are bright and cheerful, always facing the sun. They symbolize adoration, loyalty, and longevity.',
          title: 'Sunflowers are bright and cheerful'),
      Product(
          id: 6,
          name: "Daisy",
          price: "25",
          image: "images/6.jpg",
          description:
              'Daisies are simple and charming, usually white with a yellow center. They represent innocence and purity.',
          title: 'Daisies are simple and charming'),
      Product(
          id: 7,
          name: "Hydrangea",
          price: "35",
          image: "images/5.jpg",
          description:
              'Hydrangeas have large, lush blooms in various colors. They symbolize heartfelt emotions and gratitude.',
          title: 'Hydrangeas have large.'),
      Product(
          id: 8,
          name: "Peony",
          price: "22",
          image: "images/6.jpg",
          description:
              'Peonies are lush and fragrant, often used in weddings. They represent romance, prosperity, and good fortune.',
          title: 'Peonies are lush and fragran'),
      Product(
          id: 9,
          name: "Rose",
          price: "20",
          image: "images/1.jpg",
          description:
              'Known for its classic beauty and fragrance, roses are symbols of love and passion. They come in many colors, each with its own meaning.',
          title: 'Known for its classic beauty and fragrance'),
      Product(
          id: 10,
          name: "Tulip",
          price: "30",
          image: "images/7.jpg",
          description:
              'Tulips are vibrant and come in almost every color. They are often associated with spring and symbolize perfect love.',
          title: 'Tulips are vibrant and come in almost every color'),
    ]);
    // عند البداية المصفوفة المفلترة تساوي الكاملة
  }

  List<Product> _filteredProducts = []; // قائمة المنتجات المفلترة
  String _searchQuery = '';

  CartProvider() {
    _products.addAll(loadDefualtProductd());
    _filteredProducts = List.from(_products);
  }

  String get searchQuery => _searchQuery;

  // تحديث نص البحث
  void updateSearchQuery(String query) {
    _searchQuery = query;
    _filterProducts(); // تطبيق الفلترة مباشرة عند تحديث النص
    notifyListeners();
  }

  // جميع المنتجات
  List<Product> get products => _products;

  // المنتجات المفلترة
  List<Product> get filteredProducts => _filteredProducts;

  // إضافة منتج جديد
  void addProduct(Product product) {
    _products.add(product);
    _filterProducts();
    notifyListeners();
  }

  // دالة الفلترة
  void _filterProducts() {
    if (_searchQuery.isNotEmpty) {
      final query = RegExp(_searchQuery, caseSensitive: false);
      _filteredProducts = _products
          .where((product) =>
              query.hasMatch(product.name) ||
              query.hasMatch(product.description))
          .toList();
    } else {
      _filteredProducts = List.from(_products);
    }
    notifyListeners();
  }

  // المنتجات الموجودة في السلة
  List<CartItem> get cartItems => _cartItems;

  // إجمالي السعر
  double get totalPrice {
    return _cartItems.fold(0, (total, item) => total + item.totalPrice);
  }

  // عدد العناصر في السلة
  int get itemCount {
    return _cartItems.length;
  }

  // إضافة منتج إلى السلة
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

  // إزالة منتج من السلة
  void removeFromCart(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
    } else {
      _cartItems.remove(cartItem);
    }
    notifyListeners();
  }

  // مسح السلة
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
