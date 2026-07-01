import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketplace_app/app/data/models/res/profile.model.dart';
import 'package:marketplace_app/app/data/providers/api_provider.dart';

class ProfileController extends GetxController {
  final _provider = Get.find<ApiProvider>();

  Rx<Profile> profile = Profile().obs;
  var isLoading = false.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  var isPickingImage = false.obs;
  var avatar = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;

      final res = await _provider.getProfile();

      if (res.statusCode == 200) {
        profile.value = Profile.fromJson(res.data);

        final user = profile.value.user;

        nameController.text = user?.name ?? "";
        emailController.text = user?.email ?? "";
        avatar.value = user?.avatar ?? "";
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile() async {
    try {
      isLoading.value = true;

      final res = await _provider.updateProfile(
        name: nameController.text,
        email: emailController.text,
        avatar: avatar.value.isEmpty ? null : avatar.value,
      );

      if (res.statusCode == 200) {
        Get.snackbar("Success", "Profile updated successfully");
        await fetchProfile();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    if (isPickingImage.value) return;

    try {
      isPickingImage.value = true;

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (image == null) return;

      avatar.value = image.path;


    } catch (e) {
      print("Image pick error: $e");
    } finally {
      isPickingImage.value = false;
    }
  }
}