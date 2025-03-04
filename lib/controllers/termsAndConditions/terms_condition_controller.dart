import 'package:attendance_app/services/api_service.dart';

import '../../utils/import.dart';

class TermsConditionController extends GetxController {
  final BuildContext ctx;
  RxString termsCondition = ''.obs;
  RxString termsId = ''.obs;
  RxString updatedTermsTime =
      '${AppVariables.box.read(StorageKeys.termsUpdate)}'.obs;
  TextEditingController termsController = TextEditingController();

  RxBool isLoading = false.obs;

  TermsConditionController({required this.ctx});

  Future<void> refreshScreen() async {
    getTerms();
    Future.delayed(const Duration(seconds: 2));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTerms();
  }

  getTerms() async {
    try {
      isLoading.value = true;
      var res = await ApiService.getApi(Apis.getTermsAndConditions, ctx);

      if (res != null) {
        termsCondition.value = res['tc'][0]['description'];
        termsId.value = res['tc'][0]['_id'];
        updatedTermsTime.value = res['tc'][0]['updatedAt'];
        String formattedDate = DateFormat("MMM d, yyyy")
            .format(DateTime.parse(updatedTermsTime.value));
        updatedTermsTime.value = formattedDate;
        if (updatedTermsTime.value !=
            AppVariables.box.read(StorageKeys.termsUpdate)) {
          AppVariables.box
              .write(StorageKeys.termsUpdate, updatedTermsTime.value);
        }
        termsController.text = res['tc'][0]['description'];
      }
    } catch (e) {
      ShowToast.showFailedGfToast(msg: "Something went wrong", ctx: ctx);
    } finally {
      isLoading.value = false;
    }
  }
}
