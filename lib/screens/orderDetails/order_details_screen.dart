import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/buttons/primary_button.dart';
import '../../constants.dart';
import '../../viewmodels/cart_viewmodel.dart';
import 'components/order_item_card.dart';
import 'components/price_row.dart';
import 'components/total_price.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
        () => Provider.of<CartViewModel>(context, listen: false).fetchCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Orders"),
      ),
      body: Consumer<CartViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                children: [
                  const SizedBox(height: defaultPadding),

                  /// 🔥 DATA DARI API
                  ...List.generate(
                    vm.cartItems.length,
                    (index) {
                      final item = vm.cartItems[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding / 2),
                        child: OrderedItemCard(
                          title: item["name"],
                          description: "From API",
                          numOfItem: item["count"],
                          price: (item["price"]).toDouble(),
                        ),
                      );
                    },
                  ),

                  const PriceRow(text: "Subtotal", price: 28.0),
                  const SizedBox(height: defaultPadding / 2),
                  const PriceRow(text: "Delivery", price: 0),
                  const SizedBox(height: defaultPadding / 2),
                  const TotalPrice(price: 20),

                  const SizedBox(height: defaultPadding * 2),
                  PrimaryButton(
                    text: "Checkout",
                    press: () {},
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
