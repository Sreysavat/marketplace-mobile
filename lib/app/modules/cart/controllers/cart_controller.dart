import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/res/cart_item_list.dart';
import '../../../data/providers/api_provider.dart';

class CartController extends GetxController {
  final ApiProvider _provider = Get.find<ApiProvider>();

  final cart = CartList().obs;
  final isLoading = false.obs;

  // ✅ ADD checkout controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getCart();
  }

  Future<void> getCart() async {
    try {
      isLoading.value = true;

      final response = await _provider.getCart();

      if (response.statusCode == 200) {
        cart.value = CartList.fromJson(response.data);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // =========================
  // UPDATE QUANTITY (NO LOADING)
  // =========================
  Future<void> updateQuantity(int id, int qty) async {
    final items = cart.value.items;

    if (items == null) return;

    final index = items.indexWhere((e) => e.id == id);

    if (index != -1) {
      items[index].quantity = qty;
      cart.refresh(); // instant UI update
    }

    try {
      await _provider.updateCartItem(id, qty);
    } catch (e) {
      Get.snackbar("Error", "Update failed");
      await getCart(); // rollback
    }
  }

  // =========================
  // DELETE
  // =========================
  Future<void> deleteCartItem(int id) async {
    try {
      isLoading.value = true;

      final res = await _provider.deleteCartItem(id);

      if (res.statusCode == 200) {
        await getCart();
        Get.snackbar("Success", "Item removed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // =========================
  // CHECKOUT FIXED
  // =========================
  Future<void> checkout() async {
    try {
      final data = {
        "shipping_address": {
          "name": nameController.text.trim(),
          "phone": phoneController.text.trim(),
          "address": addressController.text.trim(),
        },
        "payment_method": "COD",
      };

      final response = await _provider.checkout(data);

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Order placed successfully");

        // optional: clear cart UI
        cart.value = CartList(items: []);
      } else {
        Get.snackbar("Error", "Checkout failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }
}