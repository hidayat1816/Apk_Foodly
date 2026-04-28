import 'package:flutter/material.dart';

import '../../components/section_title.dart';
import '../../constants.dart';
import '../../screens/filter/filter_screen.dart';
import '../featured/featurred_screen.dart';
import 'components/medium_card_list.dart';
import 'components/promotion_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "DELIVERY TO",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: primaryColor),
            ),
            const Text(
              "Pontianak",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FilterScreen(),
                ),
              );
            },
            child: Text(
              "Filter",
              style: Theme.of(context).textTheme.bodyLarge ??
                  const TextStyle(),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding),

              /// Banner Welcome
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding,
                ),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade300,
                  ),
                  child: const Center(
                    child: Text(
                      "Welcome to Foodly 🍔",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: defaultPadding * 2),

              /// Featured Product
              SectionTitle(
                title: "Featured Products",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const FeaturedScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: defaultPadding),

              const MediumCardList(),

              const SizedBox(height: 20),

              const PromotionBanner(),

              const SizedBox(height: 20),

              SectionTitle(
                title: "All Products",
                press: () {},
              ),

              const SizedBox(height: 16),

              const MediumCardList(),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}