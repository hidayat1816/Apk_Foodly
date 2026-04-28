import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../viewmodels/product_viewmodel.dart';

class MediumCardList extends StatefulWidget {
  const MediumCardList({super.key});

  @override
  State<MediumCardList> createState() => _MediumCardListState();
}

class _MediumCardListState extends State<MediumCardList> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ProductViewModel>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Consumer<ProductViewModel>(
        builder: (context, vm, child) {
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

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: vm.products.length,
            itemBuilder: (context, index) {
              final item = vm.products[index];

              return Container(
                width: 200,
                margin: const EdgeInsets.only(left: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        item.image,
                        height: 120,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text("⭐ ${item.star}"),
                    Text("Rp ${item.price}"),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}