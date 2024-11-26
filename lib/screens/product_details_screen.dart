import 'package:flutter/material.dart';
import 'package:gift_planner/models/product.dart';
import 'package:gift_planner/provider/CartProvider.dart';
import 'package:gift_planner/provider/FavoritesProvide.dart';
import 'package:gift_planner/screens/AllReviwes.dart';
import 'package:gift_planner/utils/design_components.dart';
//import 'package:gift_planner/utils/design_components.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
    required Null Function() addToCart,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool isFavorite = false;
  final List<Map<String, dynamic>> reviews = [
    {
      "name": "Alice Johnson",
      "comment": "Amazing product! Highly recommend.",
      "rating": 5,
      "profilePic": "images/man.png"
    },
    {
      "name": "Michael Brown",
      "comment": "Good quality, but delivery was late.",
      "rating": 4,
      "profilePic": "images/woman.png",
    },
    {
      "name": "Sarah Davis",
      "comment": "Not satisfied with the material.",
      "rating": 2,
      "profilePic": "images/man.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.name,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? AppStyles.favoritIconColor : Colors.grey),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
              if (isFavorite) {
                Provider.of<FavoriteProvider>(context, listen: false)
                    .toggleFavorite(widget.product);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Added to Favorites!"),
                  ),
                );
              } else {
                Provider.of<FavoriteProvider>(context, listen: false)
                    .toggleFavorite(widget.product);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Remove from Favorites!"),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // الصورة الكبيرة
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: double.infinity,
                    child: Image.asset(
                      widget.product.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // اسم المنتج والسعر
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "\$${widget.product.price}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppStyles.priceproduct,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // الوصف
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      widget.product.description,
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ),
                  const Divider(thickness: 1),
                  // التعليقات
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Reviews",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // الانتقال إلى صفحة جميع التقييمات
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AllReviewsScreen(product: widget.product),
                              ),
                            );
                          },
                          child: const Text(
                            "View More",
                            style: TextStyle(
                              color: Color.fromARGB(255, 108, 87, 103),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // عرض أول 3 تعليقات فقط
                  ListView.builder(
                    itemCount: reviews.length < 3
                        ? reviews.length
                        : 3, // عرض أول 3 تعليقات فقط
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final review =
                          reviews[index]; // سيتم استخدام أول 3 تعليقات فقط
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 5,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(review["profilePic"]),
                              radius: 30,
                            ),
                            title: Text(
                              review["name"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review["comment"],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: List.generate(
                                    5,
                                    (starIndex) => Icon(
                                      Icons.star,
                                      color: starIndex < review["rating"]
                                          ? Colors.amber
                                          : Colors.grey,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          // زر الإضافة إلى السلة
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false)
                      .addToCart(widget.product);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Product added to cart!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyles.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppStyles.background,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
