import 'package:flutter/material.dart';
import '../../data/cart_data.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Keranjang")),
      body: cartItems.isEmpty
          ? const Center(child: Text("Keranjang kosong"))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(item["name"]),
                  subtitle: Text("Rp ${item["price"]}"),
                );
              },
            ),
    );
  }
}