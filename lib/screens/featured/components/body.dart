import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../components/cards/big/restaurant_info_big_card.dart';
import '../../../constants.dart';
import '../../../viewmodels/product_viewmodel.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  void initState() {
    super.initState();

    // 🔥 FIX cara panggil API
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewModel>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductViewModel>();

    if (vm.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.products.isEmpty) {
      return const Center(child: Text("Data kosong"));
    }

    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.all(defaultPadding),
        itemCount: vm.products.length,
        itemBuilder: (context, index) {
          final item = vm.products[index];

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
            child: RestaurantInfoBigCard(
              images: [item.image],
              name: item.name,
              rating: item.star, // ✅ FIX
              numOfRating: 200,
              deliveryTime: 20,
              foodType: const ["Food"],
              press: () {},
            ),
          );
        },
      ),
    );
  }
}