import 'package:flutter/material.dart';
import '../../../components/cards/big/restaurant_info_big_card.dart';
import '../../../components/scalton/big_card_scalton.dart';
import '../../../constants.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoading = true;

  // 🔥 FIX: image sudah diganti PNG (AMAN, tidak SVG)
  final List<Map<String, dynamic>> partners = [
    {
      "name": "McDonald's",
      "rating": 4.3,
      "image":
          "https://logos-world.net/wp-content/uploads/2020/04/McDonalds-Logo.png",
      "tag": "Featured"
    },
    {
      "name": "KFC",
      "rating": 4.5,
      "image":
          "https://logos-world.net/wp-content/uploads/2021/03/KFC-Logo.png",
      "tag": "Popular"
    },
    {
      "name": "Burger King",
      "rating": 4.2,
      "image":
          "https://logos-world.net/wp-content/uploads/2021/01/Burger-King-Logo.png",
      "tag": "Trending"
    },
    {
      "name": "Pizza Hut",
      "rating": 4.4,
      "image":
          "https://logos-world.net/wp-content/uploads/2021/03/Pizza-Hut-Logo.png",
      "tag": "Best"
    },
  ];

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  Color _tagColor(String tag) {
    switch (tag) {
      case "Featured":
        return Colors.orange;
      case "Popular":
        return Colors.redAccent;
      case "Trending":
        return Colors.blue;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.all(defaultPadding),
        itemCount: isLoading ? 3 : partners.length,
        itemBuilder: (context, index) {
          if (isLoading) {
            return const Padding(
              padding: EdgeInsets.only(bottom: defaultPadding),
              child: BigCardScalton(),
            );
          }

          final item = partners[index];

          return Container(
            margin: const EdgeInsets.only(bottom: defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Stack(
              children: [
                // 🔥 CARD UTAMA
                RestaurantInfoBigCard(
                  images: [item["image"]],
                  name: item["name"],
                  rating: (item["rating"] as num).toDouble(),
                  numOfRating: 200,
                  deliveryTime: 20 + index * 5,
                  foodType: const ["Fast Food"],
                  press: () {},
                ),

                // 🔥 BADGE UX FEATURED
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _tagColor(item["tag"]),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      item["tag"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}