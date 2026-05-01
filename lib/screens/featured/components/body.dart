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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewModel>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductViewModel>();

    if (vm.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (vm.products.isEmpty) {
      return const Center(
        child: Text("Data kosong"),
      );
    }

    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.all(defaultPadding),
        itemCount: vm.products.length,
        itemBuilder: (context, index) {
          final item = vm.products[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  spreadRadius: 1,
                  offset: const Offset(0, 6),
                  color: Colors.black.withOpacity(0.08),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔥 CARD ASLI
                RestaurantInfoBigCard(
                  images: [item.image],
                  name: item.name,
                  rating: item.star,
                  numOfRating: 200,
                  deliveryTime: 20,
                  foodType: const ["Food"],
                  press: () {},
                ),

                /// 🔥 HARGA + TOMBOL
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rp ${item.price}",
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
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