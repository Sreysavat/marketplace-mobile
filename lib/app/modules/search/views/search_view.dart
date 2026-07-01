import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import 'package:marketplace_app/app/data/models/res/search_product.dart' ;
import 'package:marketplace_app/app/modules/search/views/product_mapper.dart';
import '../../../data/models/res/product.model.dart';
import '../../../routes/app_pages.dart';
import '../../product_detail/views/product_detail_view.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              onChanged: controller.onSearchChanged,
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: Obx(() {
                  if (controller.searchText.value.isEmpty) {
                    return const SizedBox();
                  }

                  return IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: controller.clearSearch,
                  );
                }),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.searchText.value.isEmpty) {
                  return const Center(
                    child: Text(
                      "Search for products",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                final List<DataProduct> products =
                    controller.productResult.value.data?.data ?? <DataProduct>[];

                if (products.isEmpty) {
                  return const Center(child: Text("No products found"));
                }

                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];

                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          Routes.PRODUCT_DETAIL,
                          arguments: ProductMapper.fromSearch(product),
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              product.images?.isNotEmpty == true
                                  ? product.images!.first.url ?? ""
                                  : "",
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) {
                                return Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.grey.shade200,
                                  child: const Icon(Icons.image),
                                );
                              },
                            ),
                          ),
                          title: Text(
                            product.name ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            "\$${product.basePrice ?? "0"}",
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: const Icon(Icons.favorite),
                            // onTap: () {
                              // final converted = ProductMapper.fromSearch(product);
                              //
                              // print("SEARCH TAP HIT");
                              // print(product.runtimeType);
                              // print(ProductMapper.fromSearch(product).runtimeType);
                              //
                              // Get.toNamed(
                              //   Routes.PRODUCT_DETAIL,
                              //   arguments: converted,
                              //);
                            //}
                        ),
                      ),
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}