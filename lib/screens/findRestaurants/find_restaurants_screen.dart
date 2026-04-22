import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../entry_point.dart';

import '../../components/buttons/secondery_button.dart';
import '../../components/welcome_text.dart';
import '../../constants.dart';

/// TAMBAHAN
import '../../data/cart_data.dart';
import '../cart/cart_screen.dart';

class FindRestaurantsScreen extends StatelessWidget {
  const FindRestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EntryPoint(),
              ),
            );
          },
        ),

        /// 🔥 TOMBOL CART
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CartScreen(),
                ),
              );
            },
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),

          /// 🔥 FIX UTAMA ADA DI SINI
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WelcomeText(
                  title: "Find restaurants near you ",
                  text:
                      "Please enter your location or allow access to \nyour location to find restaurants near you.",
                ),

                /// BUTTON LOCATION
                SeconderyButton(
                  press: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/location.svg",
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                          primaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Use current location",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: primaryColor),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: defaultPadding),

                /// FORM ADDRESS
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: titleColor),
                        cursorColor: primaryColor,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              "assets/icons/marker.svg",
                              colorFilter: const ColorFilter.mode(
                                  bodyTextColor, BlendMode.srcIn),
                            ),
                          ),
                          hintText: "Enter a new address",
                          contentPadding: kTextFieldPadding,
                        ),
                      ),
                      const SizedBox(height: defaultPadding),

                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EntryPoint(),
                            ),
                          );
                        },
                        child: const Text("Continue"),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: defaultPadding),

                /// 🔥 MENU
                const Text(
                  "Menu Contoh",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                /// ITEM 1
                ListTile(
                  title: const Text("Burger"),
                  subtitle: const Text("Rp 20.000"),
                  trailing: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      cartItems.add({
                        "name": "Burger",
                        "price": 20000,
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Burger ditambahkan ke keranjang"),
                        ),
                      );
                    },
                  ),
                ),

                /// ITEM 2
                ListTile(
                  title: const Text("Pizza"),
                  subtitle: const Text("Rp 50.000"),
                  trailing: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      cartItems.add({
                        "name": "Pizza",
                        "price": 50000,
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Pizza ditambahkan ke keranjang"),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}