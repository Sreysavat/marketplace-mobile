import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplace_app/app/data/providers/api_provider.dart';
import 'package:marketplace_app/app/routes/app_pages.dart';

class SignupController extends GetxController {
  final _provider = Get.find<ApiProvider>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  final isLoading = false.obs;

  /// NAVIGATION (clean separation)
  void goToVerifyOtp(String email) {
    Get.offNamed(
      Routes.VERIFYOTP,
      arguments: {'email': email},
    );
  }

  Future<void> register() async {
    if (isClosed) return;

    final name = fullNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    // ❗ move validation here (no formKey needed)
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    try {
      isLoading.value = true;

      final response = await _provider.register(
        name: name,
        email: email,
        password: password,
      );

      if (isClosed) return;

      final status = response.statusCode;

      if (status == 200 || status == 201) {
        final data = response.data;

        Get.snackbar(
          'Success',
          (data is Map<String, dynamic>)
              ? (data['message'] ?? 'Account created')
              : data.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );

        goToVerifyOtp(email);
        return;
      }

      Get.snackbar(
        'Error',
        'Unexpected server response',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on DioException catch (e) {
      if (isClosed) return;

      final statusCode = e.response?.statusCode;
      final data = e.response?.data;

      String message = 'Something went wrong';

      switch (statusCode) {
        case 400:
        case 401:
        case 403:
        case 404:
        case 409:
          message = data?['message'] ?? message;
          break;

        case 422:
          if (data is Map && data['errors'] != null) {
            final errors = data['errors'] as Map;
            message = errors.values.first[0];
          } else {
            message = data?['message'] ?? 'Validation failed';
          }
          break;

        case 429:
          message = 'Too many requests';
          break;

        case 500:
          message = 'Server error. Please try again later.';
          break;
      }

      Get.snackbar(
        'Register Failed',
        message,
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
  void goToSignin() {
    Get.offNamed(Routes.SIGNIN);
  }
  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}