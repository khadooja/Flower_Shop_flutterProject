import 'package:flutter/material.dart';
import 'package:gift_planner/provider/FavoritesProvide.dart';
import 'package:gift_planner/utils/design_components.dart';
import 'package:gift_planner/widget/productcart.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'product_details_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProducts = context.watch<FavoriteProvider>().favoriteItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        backgroundColor: AppStyles.seconderyColor,
      ),
      body: favoriteProducts.isEmpty
          ? const Center(
              child: Text(
                "No favorite products yet",
                style: AppStyles.texStyle,
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.75,
              ),
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];

                return ProductCard(
                  product: product,
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(
                          product: product,
                          addToCart: () {},
                        ),
                      ),
                    );
                  },
                  onAddToCart: () {
                    // ignore: avoid_print
                    print("${product.title} added to cart");
                  },
                  onToggleFavorite: () {
                    context.read<FavoriteProvider>().toggleFavorite(product);
                  },
                  isFavorite: true,
                  addToCart: (product) {},
                );
              },
            ),
    );
  }
}
