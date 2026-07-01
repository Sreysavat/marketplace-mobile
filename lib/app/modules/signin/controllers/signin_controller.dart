import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplace_app/app/data/providers/api_provider.dart';
import 'package:marketplace_app/app/sevices/storage_service.dart';
import 'package:marketplace_app/app/routes/app_pages.dart';

class SigninController extends GetxController {
  final _provider = Get.find<ApiProvider>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final obscurePassword = true.obs;

  /// NAVIGATION
  void goToHome() {
    Get.offAllNamed(Routes.HOME);
  }

  void goToSignup() {
    Get.offNamed(Routes.SIGNUP);
  }

  void goToVerifyOtp(String email) {
    Get.offNamed(
      Routes.VERIFYOTP,
      arguments: {'email': email},
    );
  }

  /// LOGIN
  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    // ✅ validation
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    try {
      isLoading.value = true;

      final response = await _provider.login(
        email: email,
        password: password,
      );

      final status = response.statusCode;
      final data = response.data;

      /// -----------------------------
      /// ✅ SUCCESS LOGIN
      /// -----------------------------
      if (status == 200) {
        if (data is Map<String, dynamic>) {
          await StorageService.write(
            key: 'token',
            value: data['token'],
          );
        }

        Get.snackbar(
          'Success',
          'Login successful',
          snackPosition: SnackPosition.BOTTOM,
        );

        goToHome();
        return;
      }

      /// -----------------------------
      /// ⚠️ EMAIL NOT VERIFIED CASE
      /// -----------------------------
      final message = (data is Map) ? data['message'] : data.toString();

      if (message == "Please verify your email first") {
        Get.snackbar(
          'Verify Email',
          'Please verify your email first',
          snackPosition: SnackPosition.BOTTOM,
        );

        goToVerifyOtp(email);
        return;
      }

      /// -----------------------------
      /// ❌ OTHER ERRORS
      /// -----------------------------
      Get.snackbar(
        'Login Failed',
        message ?? 'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      if (isClosed) return;

      Get.snackbar(
        'Error',
        'Unexpected error occurred',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      if (!isClosed) {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}