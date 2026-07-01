import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketplace_app/app/constant/constant.dart';
import 'package:marketplace_app/app/routes/app_pages.dart';
import '../../../widget/ProfileMenuItem.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          Obx(() {
            return IconButton(
              onPressed: controller.isLoading.value
                  ? null
                  : controller.updateProfile,
              icon: controller.isLoading.value
                  ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Icon(Icons.save),
            );
          }),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// PROFILE HEADER
            Container(
              padding: const EdgeInsets.all(20),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                final profile = controller.profile.value;
                final user = profile.user;

                if (user == null) {
                  return const Text("No user data found");
                }

                final avatarUrl = (user.avatar != null && user.avatar!.isNotEmpty)
                    ? (user.avatar!.startsWith("http")
                    ? user.avatar!
                    : "$kImageBaseUrl/${user.avatar}")
                    : null;

                return Column(
                  children: [
                    GestureDetector(
                      onTap: controller.isPickingImage.value
                          ? null
                          : controller.pickImage,
                      child: Obx(() {
                        final profile = controller.profile.value;
                        final user = profile.user;

                        final avatarUrl = (user?.avatar != null && user!.avatar!.isNotEmpty)
                            ? (user.avatar!.startsWith("http")
                            ? user.avatar!
                            : "$kImageBaseUrl/${user.avatar}")
                            : null;

                        return CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[300],
                          backgroundImage:
                          avatarUrl != null ? NetworkImage(avatarUrl) : null,
                          child: controller.isPickingImage.value
                              ? const CircularProgressIndicator()
                              : (avatarUrl == null
                              ? const Icon(Icons.camera_alt, size: 30)
                              : null),
                        );
                      }),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      user.name?.isNotEmpty == true ? user.name! : "No name",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      user.email?.isNotEmpty == true ? user.email! : "No email",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                );
              })
            ),

            const SizedBox(height: 10),

            /// MENU ITEMS
            ProfileMenuItem(
              icon: Icons.shopping_bag_outlined,
              title: "My Orders",
              onTap: () {},
            ),

            ProfileMenuItem(
              icon: Icons.favorite_border,
              title: "Wishlist",
              onTap: () {},
            ),

            ProfileMenuItem(
              icon: Icons.location_on_outlined,
              title: "Shipping Address",
              onTap: () {
                Get.toNamed(Routes.ADDRESS);
              },
            ),

            ProfileMenuItem(
              icon: Icons.settings_outlined,
              title: "Settings",
              onTap: () {},
            ),

            ProfileMenuItem(
              icon: Icons.logout,
              title: "Logout",
              isDestructive: true,
              onTap: () {
                Get.snackbar("Logout", "You clicked logout");
              },
            ),
          ],
        ),
      ),
    );
  }
}