import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../entry_point.dart';

import '../../components/buttons/secondery_button.dart';
import '../../components/welcome_text.dart';
import '../../constants.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

/// DATA
import '../../data/cart_data.dart';
import '../../data/location_data.dart';
import '../../data/food_data.dart';

import '../cart/cart_screen.dart';

class FindRestaurantsScreen extends StatelessWidget {
  const FindRestaurantsScreen({super.key});

  /// 🔥 FUNCTION GPS
  Future<void> getCurrentLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("GPS tidak aktif")),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Izin lokasi ditolak")),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition();

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemarks[0];

    userAddress = "${place.street}, ${place.locality}";

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Lokasi: $userAddress")),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const EntryPoint()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController addressController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const EntryPoint(),
              ),
            );
          },
        ),
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const WelcomeText(
                  title: "Find restaurants near you ",
                  text:
                      "Please enter your location or allow access to \nyour location to find restaurants near you.",
                ),

                /// 🔥 BUTTON GPS
                SeconderyButton(
                  press: () {
                    getCurrentLocation(context);
                  },
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

                /// 🔥 INPUT ADDRESS
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    hintText: "Enter a new address",
                  ),
                ),

                const SizedBox(height: defaultPadding),

                ElevatedButton(
                  onPressed: () {
                    if (addressController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Masukkan alamat dulu")),
                      );
                      return;
                    }

                    userAddress = addressController.text;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EntryPoint(),
                      ),
                    );
                  },
                  child: const Text("Continue"),
                ),

                const SizedBox(height: 20),

                /// 🔥 MENU MAKANAN (SUDAH DI UPGRADE)
                const Text(
                  "Menu Makanan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: foodList.length,
                  itemBuilder: (context, index) {
                    final food = foodList[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [

                          /// 🔥 GAMBAR
                          ClipRRect(
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(12),
                            ),
                            child: Image.asset(
                              food["image"],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(width: 10),

                          /// 🔥 INFO
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  food["name"],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),

                                Text("Rp ${food["price"]}"),

                                const SizedBox(height: 5),

                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.orange, size: 16),
                                    const SizedBox(width: 4),
                                    Text(food["rating"].toString()),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          /// 🔥 BUTTON TAMBAH
                          IconButton(
                            icon: const Icon(Icons.add_circle,
                                color: Colors.green),
                            onPressed: () {
                              cartItems.add({
                                "name": food["name"],
                                "price": food["price"],
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "${food["name"]} ditambahkan ke keranjang"),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
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