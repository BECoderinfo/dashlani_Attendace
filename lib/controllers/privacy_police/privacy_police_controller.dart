import 'package:attendance_app/utils/import.dart';
import '../../services/api_service.dart';

class PrivacyPoliceController extends GetxController {
  final BuildContext ctx;
  RxString privacyId = ''.obs;
  RxString updatedPrivacyTime =
      '${AppVariables.box.read(StorageKeys.privacyUpdate)}'.obs;
  RxString privacyPolicy = ''.obs;
  TextEditingController privacyPolicyController = TextEditingController();

  PrivacyPoliceController({required this.ctx});

  RxBool isLoading = false.obs;

  Future<void> refreshScreen() async {
    getPrivacyPolicy();
    Future.delayed(const Duration(seconds: 2));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPrivacyPolicy();
  }

  getPrivacyPolicy() async {
    try {
      isLoading.value = true;
      var res = await ApiService.getApi(Apis.getPrivacyPolicy, ctx);

      if (res != null) {
        privacyPolicy.value = res['policy'][0]['description'];
        privacyId.value = res['policy'][0]['_id'];
        updatedPrivacyTime.value = res['policy'][0]['updatedAt'];
        String formattedDate = DateFormat("MMM d, yyyy")
            .format(DateTime.parse(updatedPrivacyTime.value));
        updatedPrivacyTime.value = formattedDate;
        if (updatedPrivacyTime.value !=
            AppVariables.box.read(StorageKeys.privacyUpdate)) {
          AppVariables.box
              .write(StorageKeys.privacyUpdate, updatedPrivacyTime.value);
        }
        privacyPolicyController.text = res['policy'][0]['description'];
      }
    } catch (e) {
      ShowToast.showFailedGfToast(msg: "Something went wrong", ctx: ctx);
    } finally {
      isLoading.value = false;
    }
  }
}
