import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:marketplace_app/app/routes/app_pages.dart';
import 'package:marketplace_app/app/routes/nested_routes.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(



      //nested navigation
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: Routes.PRODUCT,
        onGenerateRoute: onGenerateRoute,
      ),
      bottomNavigationBar: Obx(
        (){
          return BottomNavigationBar(
            onTap: controller.onIndexChanged,
              currentIndex: controller.currentIndex.value,
              type: BottomNavigationBarType.fixed,
              items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'HOME'),
            BottomNavigationBarItem(icon: Icon(Icons.search),label: 'SEARCH'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'CART'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'FAVORITE'),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: 'PROFILE')
          ]);
        }
      ),
    );
  }
}
