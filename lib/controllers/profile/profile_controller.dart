import 'package:attendance_app/modals/employee/employee_modal.dart';

import '../../services/api_service.dart';
import '../../utils/import.dart';

class ProfileController extends GetxController {
  final BuildContext ctx;

  ProfileController({required this.ctx});

  RxString profileImage = '${AppVariables.box.read(StorageKeys.aImage)}'.obs;

  RxBool isImagePicked = false.obs;

  User? user;

  RxBool isLoading = false.obs;

  String imagePath = "";

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  Future<void> refreshScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    getUser();
  }

  getUser() async {
    try {
      isLoading.value = true;

      var response = await ApiService.getApi(
          Apis.getById(id: AppVariables.box.read(StorageKeys.aId)), ctx);

      if (response != null) {
        isLoading.value = false;
        user = User.fromJson(response['user']);
        update();
      }
    } catch (e) {
      log(e.toString());
      ShowToast.showFailedGfToast(msg: "Error getting data", ctx: ctx);
    } finally {
      isLoading.value = false;
    }
  }

  pikeImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagePath = pickedFile.path;
      print("pickedFile.path : ${pickedFile.path}");
      isImagePicked.value = true;
      update();
    }
  }

  updateProfile() async {
    try {
      isLoading.value = true;

      await pikeImage();

      if (imagePath.isEmpty) {
        throw "Please select an image";
      }

      var response = await ApiService.multipartApi(
        Apis.updateProfile(
          id: AppVariables.box.read(StorageKeys.aId),
        ),
        ctx,
        imageParamName: 'profileImage',
        imagePath: [imagePath],
        body: {},
        method: 'PUT',
      );

      if (response != null) {
        AppVariables.box.write(
            StorageKeys.aImage,
            (response['data']['profileImage'] != null)
                ? '${Apis.serverAddress}/${response['data']['profileImage']}'
                : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png");
        profileImage.value =
            '${Apis.serverAddress}/${response['data']['profileImage']}';
        update();
        ShowToast.showSuccessGfToast(msg: "Image updated", ctx: ctx);
      }
    } catch (e) {
      ShowToast.showFailedGfToast(msg: 'update Failed', ctx: ctx);
    } finally {
      isLoading.value = false;
    }
  }

  // Simulate logout
  void logout() async {
    try {
      var res = await ApiService.deleteApi(Apis.logout, ctx,
          headers: {'token': AppVariables.box.read(StorageKeys.aToken)});
      if (res != null) {
        AppVariables.box.erase();
      }
    } catch (e) {
      ShowToast.showFailedGfToast(msg: 'Logout failed', ctx: ctx);
    }
    Get.offNamedUntil(
      Routes.loginScreen,
      (route) => false,
    );
  }
}
