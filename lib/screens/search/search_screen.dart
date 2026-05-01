import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../components/cards/big/restaurant_info_big_card.dart';
import '../../components/scalton/big_card_scalton.dart';
import '../../constants.dart';
import '../../viewmodels/product_viewmodel.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  void initState() {
    super.initState();

    // 🔥 ambil data dari API saat halaman dibuka
    Future.microtask(() {
      context.read<ProductViewModel>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding),
              Text('Search', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: defaultPadding),

              // 🔍 SEARCH BAR
              const SearchForm(),

              const SizedBox(height: defaultPadding),
              Text("Search Results",
                  style: Theme.of(context).textTheme.titleLarge),

              const SizedBox(height: defaultPadding),

              // 🔥 LIST DATA DARI API
              Expanded(
                child: Consumer<ProductViewModel>(
                  builder: (context, vm, child) {
                    // loading
                    if (vm.isLoading) {
                      return ListView.builder(
                        itemCount: 2,
                        itemBuilder: (context, index) => const Padding(
                          padding: EdgeInsets.only(bottom: defaultPadding),
                          child: BigCardScalton(),
                        ),
                      );
                    }

                    // data kosong
                    if (vm.filteredProducts.isEmpty) {
                      return const Center(
                        child: Text("Data tidak ditemukan"),
                      );
                    }

                    // data ada
                    return ListView.builder(
                      itemCount: vm.filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = vm.filteredProducts[index];

                        return Padding(
                          padding:
                              const EdgeInsets.only(bottom: defaultPadding),
                          child: RestaurantInfoBigCard(
                            images: [product.image], // dari API
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
      ),
    );
  }
}

class SearchForm extends StatelessWidget {
  const SearchForm({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        // 🔥 langsung search dari ViewModel
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