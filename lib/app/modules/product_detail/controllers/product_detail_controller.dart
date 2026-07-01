import 'package:get/get.dart';
import 'package:marketplace_app/app/data/models/res/product.model.dart';
import 'package:marketplace_app/app/data/providers/api_provider.dart';
import '../../cart/controllers/cart_controller.dart';

class ProductDetailController extends GetxController {
  final _provider = Get.find<ApiProvider>();

  late final Data product;

  Rxn<Variants> selectedVariant = Rxn<Variants>();
  RxDouble currentPrice = 0.0.obs;
  RxInt quantity = 1.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    if (args is! Data) {
      throw Exception("Product argument is missing or invalid type");
    }

    product = args;

    _initVariant();
  }

  void _initVariant() {
    final variants = product.variants;

    if (variants.isEmpty) {
      currentPrice.value = _parsePrice(product.basePrice);
      return;
    }

    final defaultVariant = variants.firstWhere(
          (v) => v.isDefault == true,
      orElse: () => variants.first,
    );

    selectVariant(defaultVariant);
  }

  Variants _findDefaultVariant(List<Variants> variants) {
    try {
      return variants.firstWhere(
            (v) => v.isDefault == 1,
      );
    } catch (_) {
      return variants.first;
    }
  }

  void selectVariant(Variants variant) {
    selectedVariant.value = variant;
    currentPrice.value = _parsePrice(variant.price);
  }

  double _parsePrice(dynamic value) {
    return double.tryParse(value?.toString() ?? '0') ?? 0.0;
  }

  void increaseQty() => quantity.value++;

  void decreaseQty() {
    if (quantity.value > 1) quantity.value--;
  }

  Future<void> addProductToCart({
    required int proId,
    int? proVaId,
    required int qty,
  }) async {
    try {
      isLoading.value = true;

      final res = await _provider.addToCart(
        proId: proId,
        proVaId: proVaId,
        qty: qty,
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        Get.snackbar("Success", "Added to cart");

        if (Get.isRegistered<CartController>()) {
          await Get.find<CartController>().getCart();
        }
      } else {
        Get.snackbar(
          "Error",
          res.data?['message'] ?? "Failed to add to cart",
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}