import 'package:flutter/material.dart';
import 'package:foodly_ui/screens/details/details_screen.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/product_viewmodel.dart';
import '../../../constants.dart';

class MediumCardList extends StatefulWidget {
  const MediumCardList({super.key});

  @override
  State<MediumCardList> createState() => _MediumCardListState();
}

class _MediumCardListState extends State<MediumCardList> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() =>
        Provider.of<ProductViewModel>(context, listen: false).fetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Consumer<ProductViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: vm.products.length,
            itemBuilder: (context, index) {
              final item = vm.products[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(product: item),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  margin: const EdgeInsets.only(left: defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          item["image"],
                          height: 120,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item["name"],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text("⭐ ${item["star"]}"),
                      const SizedBox(height: 4),
                      Text("Rp ${item["price"]}"),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
