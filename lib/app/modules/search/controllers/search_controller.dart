import 'dart:async';

import 'package:get/get.dart';
import 'package:marketplace_app/app/data/models/res/search_product.dart';
import 'package:marketplace_app/app/data/providers/api_provider.dart';

class SearchController extends GetxController {
  final ApiProvider _provider = Get.find<ApiProvider>();

  final searchText = ''.obs;
  final productResult = ProductSearch().obs;
  final isLoading = false.obs;

  Timer? _debounce;

  void onSearchChanged(String query) {
    searchText.value = query.trim();

    _debounce?.cancel();

    if (searchText.value.isEmpty) {
      clearSearch();
      return;
    }

    _debounce = Timer(
      const Duration(milliseconds: 500),
          () => searchProduct(searchText.value),
    );
  }

  Future<void> searchProduct(String keyword) async {
    try {
      isLoading.value = true;

      final response = await _provider.searchProduct(keyword);

      if (response.statusCode == 200 && response.data != null) {
        productResult.value =
            ProductSearch.fromJson(Map<String, dynamic>.from(response.data));
      } else {
        productResult.value = ProductSearch();
      }
    } catch (e) {
      productResult.value = ProductSearch();

      Get.snackbar(
        "Error",
        "Failed to search products",
      );
    } finally {
      isLoading.value = false;
    }
  }

  void clearSearch() {
    _debounce?.cancel();
    searchText.value = '';
    productResult.value = ProductSearch();
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}