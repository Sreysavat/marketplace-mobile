import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:marketplace_app/app/widget/buildfield.dart';
import '../../../routes/app_pages.dart';
import '../../../widget/button_reusable.dart';
import '../../../widget/colors.dart';
import '../controllers/signin_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.withe,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Image.asset('assets/images/signin.png'),

              const Text(
                'Welcome Back 👋',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                'Sign in to continue shopping\nwith us.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff8B8BA5),
                  height: 1.5,
                ),
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

              Obx(
                () => BuildField(
                  controller: controller.passwordController,
                  hint: 'Password',
                  icon: Icons.lock_outline,
                  obscureText: controller.obscurePassword.value,
                  suffixIcon: IconButton(
                    onPressed: controller.obscurePassword.toggle,
                    icon: Icon(
                      controller.obscurePassword.value
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
                ),
              ),
              SizedBox(height: 6,),
              Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){}, child: Text('Forgot password?',style: TextStyle(color: AppColors.primary),))
                  ]),

              const SizedBox(height: 24),

              Obx(
                () => ButtonReusable(
                  isLoading: controller.isLoading.value,
                  action: controller.login,
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: controller.goToSignup,
                    child: Text(
                      "Sign Up",
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
      ),
    );
  }
}
