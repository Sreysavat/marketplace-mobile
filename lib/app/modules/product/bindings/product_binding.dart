import 'package:get/get.dart';
import 'package:marketplace_app/app/modules/profile/controllers/profile_controller.dart';

import '../controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(
      () => ProductController(),
    );
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
