import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../data/models/product_model.dart';
import '../../viewmodels/cart_viewmodel.dart';
import '../cart/cart_screen.dart';
import '../search/search_screen.dart';

class DetailsScreen extends StatelessWidget {
  final ProductModel product;

  const DetailsScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/share.svg",
              width: 20,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/search.svg",
              width: 20,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SearchScreen(),
                ),
              );
            },
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              /// IMAGE
              ClipRRect(
                borderRadius:
                    const BorderRadius.only(
                  bottomLeft:
                      Radius.circular(20),
                  bottomRight:
                      Radius.circular(20),
                ),
                child: Image.network(
                  product.image,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(
                height: defaultPadding,
              ),

              Padding(
                padding:
                    const EdgeInsets.all(
                  defaultPadding,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    /// NAME
                    Text(
                      product.name,
                      style:
                          const TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),

                    const SizedBox(
                        height: 10),

                    /// STAR
                    Text(
                      "⭐ ${product.star}",
                      style:
                          const TextStyle(
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(
                        height: 10),

                    /// PRICE
                    Text(
                      "Rp ${product.price}",
                      style:
                          const TextStyle(
                        fontSize: 22,
                        color:
                            Colors.orange,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),

                    const SizedBox(
                        height: 20),

                    /// DESCRIPTION
                    const Text(
                      "Makanan lezat dengan cita rasa terbaik, cocok untuk menemani harimu.",
                      style:
                          TextStyle(
                        fontSize: 16,
                        color: Colors
                            .black54,
                      ),
                    ),

                    const SizedBox(
                        height: 30),

                    /// ADD TO CART
                    SizedBox(
                      width:
                          double.infinity,
                      child:
                          ElevatedButton(
                        onPressed: () {
                          final cartVm =
                              context.read<
                                  CartViewModel>();

                          cartVm.addToCart({
                            "name":
                                product.name,
                            "price":
                                product.price,
                          });

                          ScaffoldMessenger.of(
                                  context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Berhasil masuk cart",
                              ),
                            ),
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const CartScreen(),
                            ),
                          );
                        },
                        child:
                            const Text(
                          "Add To Cart",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}