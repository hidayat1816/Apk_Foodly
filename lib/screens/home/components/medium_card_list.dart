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
          /// 🔄 Loading
          if (vm.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          /// ❌ Kalau kosong
          if (vm.products.isEmpty) {
            return const Center(
              child: Text("Data kosong"),
            );
          }

          /// ✅ List Data dari API
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: vm.products.length,
            itemBuilder: (context, index) {
              final item = vm.products[index];

              /// ✅ LANGSUNG PAKAI DARI API DOSEN
              final imageUrl = item.image;

              return Container(
                width: 200,
                margin: const EdgeInsets.only(left: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🖼️ GAMBAR
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl,
                        height: 120,
                        width: 200,
                        fit: BoxFit.cover,

                        /// 🔥 PENTING: biar Bing bisa tampil
                        headers: const {
                          "User-Agent": "Mozilla/5.0",
                        },

                        /// ⏳ loading
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;

                          return Container(
                            height: 120,
                            width: 200,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          );
                        },

                        /// ❌ error fallback
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 120,
                            width: 200,
                            color: Colors.grey.shade300,
                            child: const Icon(
                              Icons.broken_image,
                              size: 40,
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// 📝 Nama
                    Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    /// ⭐ Rating
                    Text("⭐ ${item.star}"),

                    /// 💰 Harga
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