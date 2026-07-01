import 'package:get/get.dart';
import 'package:marketplace_app/app/routes/app_pages.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  final pages = <String>[
    Routes.PRODUCT,
    Routes.SEARCH,
    Routes.CART,
    Routes.FAVORITE,
    Routes.PROFILE,
  ];
  void onIndexChanged (int index){
    currentIndex.value = index;
    Get.toNamed(pages[index], id: 1);
  }
}
