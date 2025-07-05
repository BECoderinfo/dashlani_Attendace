import 'package:attendance_app/utils/import.dart';

import '../../modals/activity/activity_model.dart';
import '../../services/api_service.dart';

class ActivityController extends GetxController {
  RxBool isLoading = false.obs;

  final BuildContext ctx;

  ActivityController({required this.ctx});

  RxList<ActivityModel> activityList = <ActivityModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getActivity();
  }

  Future<void> refreshScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    getActivity();
  }

  getActivity() async {
    isLoading.value = true;
    try {
      var response = await ApiService.getApi(
          "${Apis.allActivity}/${AppVariables.box.read(StorageKeys.aId)}", ctx);
      if (response != null) {
        print("hello");
        activityList.clear();

        if (response == []) {
          update();
        } else {
          for (int i = 0; i < response.length; i++) {
            activityList.add(ActivityModel.fromJson(response[i]));
          }

          activityList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          update();
        }
      }
    } catch (e) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'There was an error.',
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
