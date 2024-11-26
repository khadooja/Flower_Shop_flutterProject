import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gift_planner/models/product.dart';

class AllReviewsScreen extends StatelessWidget {
  final Product product;
  const AllReviewsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
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
        "profilePic": "images/man.png"
      },
      {
        "name": "Sarah Davis",
        "comment": "Not satisfied with the material.",
        "rating": 2,
        "profilePic": "images/woman.png",
      },
      {
        "name": "David Wilson",
        "comment": "Great value for the price!",
        "rating": 4,
        "profilePic": "images/woman.png",
      },
      {
        "name": "Emily White",
        "comment": "Absolutely loved it! Will buy again.",
        "rating": 5,
        "profilePic": "images/woman.png",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Reviews"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Average Rating
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "4.6/5",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "102 Reviews",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Bar Chart
                  SizedBox(
                    height: 200, // تحديد ارتفاع ثابت
                    width: 200, // تحديد عرض ثابت
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 5,
                        barGroups: [
                          BarChartGroupData(x: 0, barRods: [
                            BarChartRodData(
                                toY: 3.5, color: Colors.blue, width: 15)
                          ]),
                          BarChartGroupData(x: 1, barRods: [
                            BarChartRodData(
                                toY: 4.2, color: Colors.green, width: 15)
                          ]),
                          BarChartGroupData(x: 2, barRods: [
                            BarChartRodData(
                                toY: 2.8, color: Colors.orange, width: 15)
                          ]),
                          BarChartGroupData(x: 3, barRods: [
                            BarChartRodData(
                                toY: 4.0, color: Colors.red, width: 15)
                          ]),
                        ],
                        titlesData: const FlTitlesData(show: true),
                        borderData: FlBorderData(show: true),
                        gridData: const FlGridData(show: true),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Reviews Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "User Reviews",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            ListView.builder(
              itemCount: reviews.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final review = reviews[index];
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
                        backgroundImage: NetworkImage(review["profilePic"]),
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
          ],
        ),
      ),
    );
  }
}
