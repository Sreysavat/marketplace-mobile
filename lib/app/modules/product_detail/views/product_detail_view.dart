import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_detail_controller.dart';
import 'package:marketplace_app/app/widget/button_reusable.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final product = controller.product;

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      appBar: AppBar(
        title: Text(product.name ?? ''),
        centerTitle: true,
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black12,
              ),
            ],
          ),
          child: Obx(
                () => ButtonReusable(
              isLoading: controller.isLoading.value,
              action: () {
                final variant = controller.selectedVariant.value;

                if (product.variants != null &&
                    product.variants!.isNotEmpty &&
                    variant == null) {
                  Get.snackbar(
                    "Select Variant",
                    "Please select a variant first",
                  );
                  return;
                }

                controller.addProductToCart(
                  proId: product.id!,
                  proVaId: variant?.id,
                  qty: controller.quantity.value,
                );
              },
              textBtt: "Add To Cart",
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// IMAGE
            Obx(() {
              final images = product.images ?? [];

              // fallback if no images
              if (images.isEmpty &&
                  controller.selectedVariant.value?.image == null) {
                return Container(
                  color: Colors.white,
                  height: 320,
                  width: double.infinity,
                  child: const Icon(Icons.image, size: 100),
                );
              }

              // build image list (variant image first if exists)
              final List<String> imageUrls = [];

              if (controller.selectedVariant.value?.image != null &&
                  controller.selectedVariant.value!.image!.isNotEmpty) {
                imageUrls.add(controller.selectedVariant.value!.image!);
              }

              imageUrls.addAll(
                images
                    .where((e) => (e.url ?? '').isNotEmpty)
                    .map((e) => e.url!)
                    .toList(),
              );

              return SizedBox(
                height: 320,
                width: double.infinity,
                child: PageView.builder(
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      imageUrls[index],
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image, size: 100),
                    );
                  },
                ),
              );
            }),

            const SizedBox(height: 10),

            /// INFO
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    product.name ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Obx(() => Text(
                    "\$${controller.currentPrice.value.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  )),

                  const SizedBox(height: 10),

                  Text(product.description ?? ''),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// VARIANTS
            if ((product.variants).isNotEmpty)
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select Variant",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    Obx(() {
                      final variants = product.variants;

                      if (variants.isEmpty) {
                        return const SizedBox();
                      }

                      return Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: variants.map((variant) {
                          final selected =
                              controller.selectedVariant.value?.id == variant.id;

                          // 🔥 SAFE attributes handling (NO NULL CRASH EVER)
                          final attributes = variant.attributes ?? [];

                          final label = attributes.isNotEmpty
                              ? attributes
                              .where((e) =>
                          e.attributeName != null && e.value != null)
                              .map((e) => "${e.attributeName}: ${e.value}")
                              .join(" / ")
                              : (variant.sku ?? "Variant");

                          return InkWell(
                            onTap: () => controller.selectVariant(variant),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color:
                                  selected ? Colors.orange : Colors.grey.shade300,
                                  width: 2,
                                ),
                                color:
                                selected ? Colors.orange.shade50 : Colors.white,
                              ),
                              child: Text(
                                label,
                                style: TextStyle(
                                  color: selected ? Colors.orange : Colors.black,
                                  fontWeight:
                                  selected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }),
                  ],
                ),
              ),

            const SizedBox(height: 10),

            /// QUANTITY
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Obx(
                    () => Row(
                  children: [
                    IconButton(
                      onPressed: controller.decreaseQty,
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text(
                      controller.quantity.value.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: controller.increaseQty,
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}