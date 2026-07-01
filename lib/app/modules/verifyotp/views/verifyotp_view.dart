import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widget/colors.dart';
import '../controllers/verifyotp_controller.dart';

class VerifyotpView extends GetView<VerifyOtpController> {
  const VerifyotpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.withe,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 60),

              Icon(
                Icons.mark_email_read_outlined,
                size: 120,
                color: AppColors.primary,
              ),

              const SizedBox(height: 30),

              Text(
                'Verify OTP',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'We sent a verification code to',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(color: Colors.grey),
              ),

              const SizedBox(height: 5),

              Text(
                controller.email,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 40),

              /// OTP INPUT
              TextFormField(
                controller: controller.otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 10,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  hintText: '000000',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// VERIFY BUTTON
              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : Text(
                      'Verify',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 20),

              /// RESEND OTP
              Obx(() {
                return TextButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.resendOtp,
                  child: Text(
                    'Resend OTP',
                    style: GoogleFonts.poppins(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}