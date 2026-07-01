import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/providers/api_provider.dart';
import '../../../routes/app_pages.dart';
import '../../../sevices/storage_service.dart';

class VerifyOtpController extends GetxController {
  final otpController = TextEditingController();
  final ApiProvider _provider = Get.find<ApiProvider>();

  final isLoading = false.obs;

  String get email => Get.arguments?['email'] ?? '';

  Future<void> verifyOtp() async {
    if (email == null) return;

    final otp = otpController.text.trim();
    if (otp.length != 6) return;

    try {
      isLoading.value = true;

      final response = await _provider.verifyOtp(
        email: email!,
        otp: otp,
      );

      if (isClosed) return; // 🔥 IMPORTANT

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'OTP verified');

        Future.delayed(const Duration(milliseconds: 200), () {
          if (!Get.isRegistered<VerifyOtpController>()) return;
          Get.offAllNamed(Routes.SIGNIN);
        });
      }

    } finally {
      if (!isClosed) {
        isLoading.value = false;
      }
    }
  }

  Future<void> resendOtp() async {
    if (email.isEmpty) return;

    await _provider.resendOtp(email: email);

    Get.snackbar('Success', 'OTP sent again');
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}