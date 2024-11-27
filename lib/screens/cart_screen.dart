import 'package:flutter/material.dart';
import 'package:gift_planner/provider/CartProvider.dart';
import 'package:gift_planner/utils/design_components.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import '../models/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required List<dynamic> cartItems});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      backgroundColor: AppStyles.background,
      appBar: AppBar(
        backgroundColor: AppStyles.background,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            const Text(
              "Your Cart",
              style: TextStyle(color: AppStyles.textColor),
            ),
            Text(
              "${cartProvider.itemCount} items",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: AppStyles.textColor),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: cartItems.isEmpty
            ? const Center(
                child: Text(
                  "Your cart is empty",
                  style: AppStyles.texStyle,
                ),
              )
            : ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Dismissible(
                      key: Key(cartItem.product.name),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        cartProvider.removeallFromCart1(cartItem);
                      },
                      background: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE6E6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Row(
                          children: [
                            Spacer(),
                            Icon(Icons.delete, color: Colors.red),
                          ],
                        ),
                      ),
                      child: CartCard(cartItem: cartItem),
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: CheckoutCard(total: cartProvider.totalPrice),
    );
  }
}

class CheckoutCard extends StatelessWidget {
  final double total;

  const CheckoutCard({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 30,
      ),
      decoration: BoxDecoration(
        color: AppStyles.background,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total: \$${total.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Checkout Complete!")),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppStyles.seconderyColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              "Checkout",
              style: TextStyle(
                fontSize: 16,
                color: AppStyles.background,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartCard extends StatelessWidget {
  final CartItem cartItem;

  const CartCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(cartItem.product.image),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cartItem.product.name,
              style: const TextStyle(color: AppStyles.textColor, fontSize: 16),
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: "\$${cartItem.product.price}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppStyles.priceproduct,
                ),
                children: [
                  TextSpan(
                    text: " x${cartItem.quantity}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => cartProvider.addToCart(cartItem.product),
                  icon: const Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () => cartProvider.removeFromCart(cartItem),
                  icon: const Icon(Icons.remove),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
