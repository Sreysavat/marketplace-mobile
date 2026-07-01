import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace_app/app/routes/app_pages.dart';
import 'package:marketplace_app/app/widget/button_reusable.dart';

import '../../../widget/buildfield.dart';
import '../../../widget/colors.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Image.asset('assets/images/backgrounsignup.png'),

            const Text(
              'Create Account',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Join us today! Please fill in the details\n'
                  'to get started.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff8B8BA5),
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),

            BuildField(
              controller: controller.fullNameController,
              hint: 'Full Name',
              icon: Icons.person_outline,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            BuildField(
              controller: controller.emailController,
              hint: 'Email',
              icon: Icons.email_outlined,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }

                if (!GetUtils.isEmail(value)) {
                  return 'Invalid email';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            Obx(() => BuildField(
              controller: controller.passwordController,
              hint: 'Password',
              icon: Icons.lock_outline,
              obscureText: controller.isPasswordHidden.value,
              suffixIcon: IconButton(
                onPressed: controller.isPasswordHidden.toggle,
                icon: Icon(
                  controller.isPasswordHidden.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password required';
                }

                if (value.length < 6) {
                  return 'Minimum 6 characters';
                }

                return null;
              },
            )),

            const SizedBox(height: 16),

            Obx(() => BuildField(
              controller: controller.confirmPasswordController,
              hint: 'Confirm Password',
              icon: Icons.lock_reset,
              obscureText: controller.isConfirmPasswordHidden.value,
              suffixIcon: IconButton(
                onPressed: controller.isConfirmPasswordHidden.toggle,
                icon: Icon(
                  controller.isConfirmPasswordHidden.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),
              validator: (value) {
                if (value != controller.passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            )),

            const SizedBox(height: 24),

            Obx(() => ButtonReusable(
              isLoading: controller.isLoading.value,
              action: controller.register,
              textBtt: 'Sign Up',
            )),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "already have an account?",
                  style: GoogleFonts.poppins(),
                ),
                TextButton(
                  onPressed: controller.goToSignin,
                  child: Text(
                    "Sign In",
                    style: GoogleFonts.poppins(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}