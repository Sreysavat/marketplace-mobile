import 'package:get/get.dart';
import 'package:marketplace_app/app/data/models/res/user_address.model.dart';
import 'package:marketplace_app/app/data/providers/api_provider.dart';

class AddressController extends GetxController {
  final _api = Get.find<ApiProvider>();

  RxBool isLoading = false.obs;
  RxList<UserAddress> addresses = <UserAddress>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAddress();
  }

  Future<void> fetchAddress() async {
    try {
      isLoading.value = true;

      final response = await _api.getAddress();
      final List list = response.data["data"] ?? [];

      addresses.assignAll(
        list.map((e) => UserAddress.fromJson(e)).toList(),
      );
    } catch (e) {
      print(e);
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}