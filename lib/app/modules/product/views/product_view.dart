import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplace_app/app/constant/constant.dart';

import '../../../data/models/res/product.model.dart';
import '../../../routes/app_pages.dart';
import '../../../widget/category.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/product_controller.dart';

class ProductView extends GetView<ProductController> {
   ProductView({super.key});

  final ProfileController profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange,
        elevation: 0,
        toolbarHeight: 70,
        title: Obx(() {
          final user = profileController.profile.value.user;

          final avatarUrl = (user?.avatar != null && user!.avatar!.isNotEmpty)
              ? (user.avatar!.startsWith("http")
              ? user.avatar!
              : "$kImageBaseUrl/${user.avatar}")
              : null;

          return Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage:
                avatarUrl != null ? NetworkImage(avatarUrl) : null,
                child: avatarUrl == null
                    ? const Icon(Icons.person)
                    : null,
              ),

              const SizedBox(width: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    user?.name ?? "Guest",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            color: Colors.white,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.fetchProducts,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 10),

                _buildSearchBar(),

                _buildBanner(),

                const SizedBox(height: 10),

                _sectionTitle("Categories"),
                const SizedBox(height: 10),

                _buildCategories(),

                const SizedBox(height: 15),

                _sectionTitle("Flash Sale 🔥"),

                _buildFlashSale(),

                const SizedBox(height: 15),

                _sectionTitle("Recommended for you"),

                _buildProductGrid(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              color: Colors.black12,
            )
          ],
        ),
        child: const TextField(
          decoration: InputDecoration(
            icon: Icon(Icons.search),
            hintText: "Search products...",
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      height: 160,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          "https://images.unsplash.com/photo-1523275335684-37898b6baf30",
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return Container(
              color: Colors.orange.shade100,
              child: const Icon(Icons.image),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          CategoryItem(
            icon: Icons.phone_android,
            label: "Phone",
          ),
          CategoryItem(
            icon: Icons.laptop,
            label: "Laptop",
          ),
          CategoryItem(
            icon: Icons.headphones,
            label: "Audio",
          ),
          CategoryItem(
            icon: Icons.watch,
            label: "Watch",
          ),
        ],
      ),
    );
  }

  Widget _buildFlashSale() {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.products.length,
        itemBuilder: (_, index) {
          final product = controller.products[index];

          return _FlashSaleCard(product: product);
        },
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: controller.products.length,
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .65,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (_, index) {
        return _ProductCard(
          product: controller.products[index],
        );
      },
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Data product;

  const _ProductCard({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final image =
    product.images?.isNotEmpty == true
        ? product.images!.first.url ?? ''
        : '';

    final price = product.hasVariants == true
        ? product.variants!.map((e) => double.parse(e.price ?? '0')).reduce((a, b) => a < b ? a : b)
        : double.parse(product.basePrice ?? '0');
    final Product products;

    return GestureDetector(
      onTap: (){

        print("Product tapped: ${product.name}");
        Get.toNamed(
          Routes.PRODUCT_DETAIL,
          arguments: product,
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                image,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.image),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? '',
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    product.category?.name ?? '',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "\$${price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          size: 14,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          "${product.rating ?? '0.0'}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlashSaleCard extends StatelessWidget {
  final Data product;

  const _FlashSaleCard({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final image =
    product.images?.isNotEmpty == true
        ? product.images!.first.url ?? ''
        : '';



    return Container(
      width: 160,
      margin: const EdgeInsets.only(left: 12),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    product.name ?? '',
                    maxLines: 1,
                  ),
              Text(
                "\$${product.basePrice ?? '0.00'}",
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}