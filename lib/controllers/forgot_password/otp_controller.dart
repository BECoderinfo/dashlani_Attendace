import 'package:attendance_app/services/api_service.dart';
import 'package:attendance_app/utils/import.dart';

class OtpController extends GetxController {
  final BuildContext ctx;

  OtpController({required this.ctx});

  RxBool isLoading = false.obs;

  TextEditingController otpController = TextEditingController();

  otpVerify() async {
    if (otpController.text.isEmpty) return;

    try {
      isLoading.value = true;

      var res = await ApiService.postApi(
        Apis.otpVerification,
        ctx,
        body: {'otp': otpController.text},
      );

      if (res != null) {
        Get.toNamed(Routes.newPassword, arguments: Get.arguments);
      }
    } catch (e) {
      ShowToast.showFailedGfToast(msg: e.toString(), ctx: ctx);
    } finally {
      update();
      isLoading.value = false;
    }
  }
}
