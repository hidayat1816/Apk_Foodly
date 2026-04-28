import 'package:flutter/material.dart';

import '../../components/cards/big/big_card_image_slide.dart';
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
        title: Column(
          children: [
            Text(
              "Delivery to".toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: primaryColor),
            ),
            const Text(
              "Pontianak",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FilterScreen(),
                ),
              );
            },
            child: Text(
              "Filter",
              style: Theme.of(context).textTheme.bodyLarge,
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

              /// 🔥 Banner sederhana (tanpa demo_data)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
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

              /// 🔥 PRODUCT DARI API
              SectionTitle(
                title: "Featured Products",
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FeaturedScreen(),
                  ),
                ),
              ),

              const SizedBox(height: defaultPadding),

              /// ✅ INI SUDAH API
              const MediumCardList(),

              const SizedBox(height: 20),

              /// Banner tetap boleh (UI saja)
              const PromotionBanner(),

              const SizedBox(height: 20),

              SectionTitle(
                title: "All Products",
                press: () {},
              ),

              const SizedBox(height: 16),

              /// 🔥 API lagi (boleh reuse)
              const MediumCardList(),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
