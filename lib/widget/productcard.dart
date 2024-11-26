import 'package:flutter/material.dart';
import 'package:gift_planner/models/product.dart';
import 'package:gift_planner/provider/FavoritesProvide.dart';
import 'package:gift_planner/utils/design_components.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onPress,
    required this.onAddToCart,
    required this.onToggleFavorite,
    required this.isFavorite,
    required Null Function(dynamic product) addToCart,
    //required Null Function(dynamic product) addToCart,
  });

  final Product product; // تأكد أن Product هو النوع الصحيح
  final VoidCallback onPress;
  final VoidCallback onAddToCart;
  final VoidCallback onToggleFavorite;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final isFavorite =
        context.watch<FavoriteProvider>().favoriteItems.contains(product);
    return GestureDetector(
      onTap: onPress, // عند الضغط على الصورة تفتح صفحة التفاصيل
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF979797).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  product.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              product.title,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "\$${product.price}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppStyles.priceproduct,
                  ),
                ),
              ),
              // الأيقونات
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<FavoriteProvider>().toggleFavorite(product);
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color:
                          isFavorite ? AppStyles.favoritIconColor : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: onAddToCart, // إضافة المنتج إلى السلة
                    icon: const Icon(Icons.add_shopping_cart),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
