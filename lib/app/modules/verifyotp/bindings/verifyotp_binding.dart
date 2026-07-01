import 'package:get/get.dart';

import '../controllers/verifyotp_controller.dart';

class VerifyOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyOtpController>(
      () => VerifyOtpController(),
    );
  }
}
