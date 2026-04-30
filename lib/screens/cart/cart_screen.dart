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
      appBar: AppBar(
        title: const Text("Keranjang"),
        centerTitle: true,
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
              child: Text(
                "Keranjang kosong",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            );
          }

          return Column(
            children: [
              /// LIST PRODUCT
              Expanded(
                child: ListView.builder(
                  itemCount:
                      vm.cartItems.length,
                  itemBuilder:
                      (context, index) {
                    final item =
                        vm.cartItems[index];

                    return Card(
                      margin:
                          const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Icons.fastfood,
                          color:
                              Colors.orange,
                        ),
                        title: Text(
                          item["name"],
                        ),
                        subtitle: Text(
                          "Rp ${item["price"]}",
                        ),

                        trailing:
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
                      ),
                    );
                  },
                ),
              ),

              /// TOTAL + CHECKOUT
              Container(
                padding:
                    const EdgeInsets.all(
                        16),
                decoration:
                    const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color:
                          Colors.grey,
                    ),
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
                                18,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                        height: 15),

                    SizedBox(
                      width: double
                          .infinity,
                      child:
                          ElevatedButton(
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