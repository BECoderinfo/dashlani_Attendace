import 'package:attendance_app/services/api_service.dart';
import 'package:attendance_app/utils/import.dart';

class ForgotPasswordController extends GetxController {
  final BuildContext ctx;

  ForgotPasswordController({required this.ctx});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;

  TextEditingController emailController = TextEditingController();

  submit() async {
    if (!formKey.currentState!.validate()) return;
    try {
      isLoading.value = true;
      var res = await ApiService.postApi(
          Apis.forgetPassword, body: {"email": emailController.text}, ctx);
      if (res != null) {
        Get.offNamed(Routes.otp, arguments: {"email": emailController.text});
      }
    } catch (e) {
      ShowToast.showFailedGfToast(msg: e.toString(), ctx: ctx);
    } finally {
      isLoading.value = false;
    }
  }
}
