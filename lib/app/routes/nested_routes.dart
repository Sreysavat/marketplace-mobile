import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplace_app/app/modules/cart/bindings/cart_binding.dart';
import 'package:marketplace_app/app/modules/cart/views/cart_view.dart';
import 'package:marketplace_app/app/modules/category/bindings/category_binding.dart';
import 'package:marketplace_app/app/modules/category/views/category_view.dart';
import 'package:marketplace_app/app/modules/favorite/bindings/favorite_binding.dart';
import 'package:marketplace_app/app/modules/favorite/views/favorite_view.dart';
import 'package:marketplace_app/app/modules/product/bindings/product_binding.dart';
import 'package:marketplace_app/app/modules/product/views/product_view.dart';
import 'package:marketplace_app/app/modules/profile/bindings/profile_binding.dart';
import 'package:marketplace_app/app/modules/profile/views/profile_view.dart';
import 'package:marketplace_app/app/modules/search/bindings/search_binding.dart';
import 'package:marketplace_app/app/modules/search/views/search_view.dart';
import 'package:marketplace_app/app/routes/app_pages.dart';

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == Routes.PRODUCT) {
      return GetPageRoute(
        settings: settings,
        page: () => ProductView(),
        binding: ProductBinding(),
      );
    }
    if (settings.name == Routes.CATEGORY) {
      return GetPageRoute(
        page: () => CategoryView(),
        binding: CategoryBinding(),
      );
    }
    if (settings.name == Routes.CART) {
      return GetPageRoute(page: () => CartView(), binding: CartBinding());
    }
    if (settings.name == Routes.FAVORITE) {
      return GetPageRoute(
        page: () => FavoriteView(),
        binding: FavoriteBinding(),
      );
    }
    if (settings.name == Routes.PROFILE) {
      return GetPageRoute(page: () => ProfileView(), binding: ProfileBinding());
    }

    if (settings.name == Routes.SEARCH) {
      return GetPageRoute(page: () => SearchView(), binding: SearchBinding());
    }
  }

// GetPage(
// name: _Paths.PRODUCT,
// page: () => const ProductView(),
// binding: ProductBinding(),
// children: [
// GetPage(
// name: _Paths.PRODUCT,
// page: () => const ProductView(),
// binding: ProductBinding(),
// ),
// ],
// ),
// GetPage(
// name: _Paths.SEARCH,
// page: () => const SearchView(),
// binding: SearchBinding(),
// ),
// GetPage(
// name: _Paths.CATEGORY,
// page: () => const CategoryView(),
// binding: CategoryBinding(),
// ),
// GetPage(
// name: _Paths.CART,
// page: () => const CartView(),
// binding: CartBinding(),
// ),
// GetPage(
// name: _Paths.FAVORITE,
// page: () => const FavoriteView(),
// binding: FavoriteBinding(),
// ),
// GetPage(
// name: _Paths.PROFILE,
// page: () => const ProfileView(),
// binding: ProfileBinding(),
// ),