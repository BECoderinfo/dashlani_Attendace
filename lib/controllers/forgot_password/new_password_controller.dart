import 'package:attendance_app/services/api_service.dart';
import 'package:attendance_app/utils/import.dart';

class NewPasswordController extends GetxController {
  final BuildContext ctx;

  NewPasswordController({required this.ctx});

  String email = Get.arguments['email'];

  final isPasswordHidden = true.obs;
  final isCPasswordHidden = true.obs;
  RxBool isLoading = false.obs;

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleCPasswordVisibility() {
    isCPasswordHidden.value = !isCPasswordHidden.value;
  }

  updatePassword() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      isLoading.value = true;

      var res = await ApiService.postApi(Apis.changePassword, ctx, body: {
        "email": email,
        "newPassword": newPasswordController.text,
      });
      if (res != null) {
        ShowToast.showSuccessGfToast(
            msg: "Password updated successfully", ctx: ctx);
        Get.offAllNamed(Routes.loginScreen);
      }
    } catch (e) {
      ShowToast.showFailedGfToast(msg: "Change Password Failed", ctx: ctx);
    } finally {
      isLoading.value = false;
    }
  }
}
