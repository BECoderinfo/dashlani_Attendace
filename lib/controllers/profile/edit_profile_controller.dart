import 'package:attendance_app/modals/employee/employee_modal.dart';
import 'package:attendance_app/services/api_service.dart';
import 'package:attendance_app/utils/import.dart';

class EditProfileController extends GetxController {
  final BuildContext ctx;
  final User user = Get.arguments;

  RxBool isLoading = false.obs;

  EditProfileController({required this.ctx});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    nameController.text = user.name ?? '';
    emailController.text = user.email ?? '';
    phoneController.text = user.phone ?? '';
    addressController.text = user.address ?? '';
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }

  updateData() async {
    try {
      isLoading.value = true;

      var res = await ApiService.putApi(
        Apis.updateProfile(id: user.id),
        ctx,
        body: {
          "name": nameController.text,
          "email": emailController.text,
          "phone": phoneController.text,
          "address": addressController.text,
        },
      );

      if (res != null) {
        ShowToast.showSuccessGfToast(
            msg: "Profile updated successfully", ctx: ctx);
        Get.back();
      }
    } catch (e) {
      ShowToast.showFailedGfToast(msg: e.toString(), ctx: ctx);
    } finally {
      isLoading.value = false;
    }
  }
}
