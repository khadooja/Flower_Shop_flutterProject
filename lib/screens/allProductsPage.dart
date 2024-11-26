import 'package:flutter/material.dart';
import 'package:gift_planner/models/product.dart';
import 'package:gift_planner/provider/CartProvider.dart';
import 'package:gift_planner/provider/FavoritesProvide.dart';
import 'package:gift_planner/screens/cart_screen.dart';
import 'package:gift_planner/screens/product_details_screen.dart';
import 'package:gift_planner/utils/design_components.dart';
import 'package:gift_planner/widget/productcart.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

// شاشة المنتجات
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.background,
      appBar: AppBar(
        title: const Text("Products"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          // زر السلة
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(
                    cartItems: context.read<CartProvider>().cartItems,
                  ),
                ),
              );
            },
          ),
          // زر المفضلة
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, "/favorites");
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return GridView.builder(
                itemCount: demoProducts.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  var product = demoProducts[index];
                  return ProductCard(
                    product: product,
                    onPress: () {
                      // عند الضغط على الصورة ينتقل إلى تفاصيل المنتج
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(
                            product: product,
                            addToCart: () {
                              // إضافة CartItem إلى السلة
                              context.read<CartProvider>().addToCart(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Product added to cart!")),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    onAddToCart: () {
                      // إضافة CartItem إلى السلة
                      context.read<CartProvider>().addToCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Product added to cart!")),
                      );
                    },
                    onToggleFavorite: () {
                      // إضافة أو إزالة المنتج من المفضلة
                      context.read<FavoriteProvider>().toggleFavorite(product);
                    },
                    isFavorite: context
                        .watch<FavoriteProvider>()
                        .favoriteItems
                        .contains(product),
                    addToCart: (product) {},
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
