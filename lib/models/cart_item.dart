import 'package:gift_planner/models/product.dart';

class CartItem {
  final Product product;
  int quantity;
  //int numOfItem = 1;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
  List<CartItem> demoCart = [];

  double get totalPrice =>
      quantity * double.parse(product.price.replaceAll(' ر.س', ''));
}
