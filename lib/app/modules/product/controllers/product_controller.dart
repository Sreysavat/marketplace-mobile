import 'package:get/get.dart';
import 'package:marketplace_app/app/data/models/res/product.model.dart';
import 'package:marketplace_app/app/data/providers/api_provider.dart';

class ProductController extends GetxController {
  final _provider = Get.find<ApiProvider>();

  RxBool isLoading = false.obs;

  RxList<Data> products = <Data>[].obs;

  // store selected variant per product
  RxMap<int, Variants> selectedVariants = <int, Variants>{}.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void selectVariant(int productId, Variants variant) {
    selectedVariants[productId] = variant;
  }

  Variants? getSelectedVariant(int productId) {
    return selectedVariants[productId];
  }
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;

      final response = await _provider.getProducts();

      if (response.statusCode == 200) {
        final Product productResponse =
        Product.fromJson(response.data);

        products.assignAll(productResponse.data ?? []);
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}