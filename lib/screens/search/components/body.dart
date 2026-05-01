import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../components/cards/big/restaurant_info_big_card.dart';
import '../../../components/scalton/big_card_scalton.dart';
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

    // 🔥 ambil data dari API
    Future.microtask(() {
      context.read<ProductViewModel>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            Text('Search',
                style: Theme.of(context).textTheme.headlineMedium),

            const SizedBox(height: defaultPadding),

            // 🔍 SEARCH
            buildSearchForm(),

            const SizedBox(height: defaultPadding),

            Text("Search Results",
                style: Theme.of(context).textTheme.titleLarge),

            const SizedBox(height: defaultPadding),

            // 🔥 DATA API
            Expanded(
              child: Consumer<ProductViewModel>(
                builder: (context, vm, child) {

                  // loading
                  if (vm.isLoading) {
                    return ListView.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) => const Padding(
                        padding:
                            EdgeInsets.only(bottom: defaultPadding),
                        child: BigCardScalton(),
                      ),
                    );
                  }

                  // kosong
                  if (vm.filteredProducts.isEmpty) {
                    return const Center(
                      child: Text("Data tidak ditemukan"),
                    );
                  }

                  // tampil data
                  return ListView.builder(
                    itemCount: vm.filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = vm.filteredProducts[index];

                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: defaultPadding),
                        child: RestaurantInfoBigCard(
                          images: [product.image],
                          name: product.name,
                          rating: product.star,
                          numOfRating: 100,
                          deliveryTime: 20,
                          foodType: const ["Food"],
                          press: () {},
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔍 SEARCH FUNCTION
  Widget buildSearchForm() {
    return TextFormField(
      onChanged: (value) {
        context.read<ProductViewModel>().searchProduct(value);
      },
      style: Theme.of(context).textTheme.labelLarge,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: "Search food...",
        contentPadding: kTextFieldPadding,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'assets/icons/search.svg',
            colorFilter: const ColorFilter.mode(
              bodyTextColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}