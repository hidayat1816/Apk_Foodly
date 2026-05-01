import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/cart_viewmodel.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() =>
      _CartScreenState();
}

class _CartScreenState
    extends State<CartScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<CartViewModel>()
          .fetchCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xfff5f5f5),

      appBar: AppBar(
        title: const Text("Keranjang"),
        centerTitle: true,
        elevation: 0,
      ),

      body: Consumer<CartViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          if (vm.cartItems.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 70,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Keranjang kosong",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              /// LIST ITEM
              Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.all(
                          12),
                  itemCount:
                      vm.cartItems.length,
                  itemBuilder:
                      (context, index) {
                    final item =
                        vm.cartItems[index];

                    return Container(
                      margin:
                          const EdgeInsets.only(
                              bottom: 12),
                      padding:
                          const EdgeInsets.all(
                              12),
                      decoration:
                          BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius
                                .circular(
                                    18),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors
                                .black
                                .withOpacity(
                                    0.05),
                            offset:
                                const Offset(
                                    0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          /// ICON
                          Container(
                            height: 60,
                            width: 60,
                            decoration:
                                BoxDecoration(
                              color: Colors
                                  .green
                                  .withOpacity(
                                      0.1),
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          14),
                            ),
                            child: const Icon(
                              Icons.fastfood,
                              color:
                                  Colors.green,
                              size: 32,
                            ),
                          ),

                          const SizedBox(
                              width: 12),

                          /// TEXT
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [
                                Text(
                                  item["name"],
                                  style:
                                      const TextStyle(
                                    fontSize:
                                        16,
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),
                                const SizedBox(
                                    height:
                                        6),
                                Text(
                                  "Rp ${item["price"]}",
                                  style:
                                      const TextStyle(
                                    color:
                                        Colors.green,
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// DELETE
                          IconButton(
                            icon:
                                const Icon(
                              Icons.delete,
                              color:
                                  Colors.red,
                            ),
                            onPressed: () {
                              vm.removeFromCart(
                                  index);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              /// TOTAL + CHECKOUT
              Container(
                padding:
                    const EdgeInsets.all(
                        18),
                decoration:
                    const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(
                    top: Radius.circular(
                        24),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style:
                              TextStyle(
                            fontSize:
                                18,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                        Text(
                          "Rp ${vm.getTotal()}",
                          style:
                              const TextStyle(
                            fontSize:
                                20,
                            color:
                                Colors.green,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                        height: 16),

                    SizedBox(
                      width: double
                          .infinity,
                      height: 50,
                      child:
                          ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.green,
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    14),
                          ),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(
                                  context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Checkout berhasil",
                              ),
                            ),
                          );
                        },
                        child:
                            const Text(
                          "Checkout",
                          style:
                              TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}