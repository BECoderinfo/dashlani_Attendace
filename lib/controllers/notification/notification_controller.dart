import 'package:attendance_app/modals/notification/notification_modal.dart';
import 'package:attendance_app/services/api_service.dart';
import 'package:attendance_app/utils/import.dart';

class NotificationController extends GetxController {
  final BuildContext ctx;

  NotificationController({required this.ctx});

  RxBool isLoading = false.obs;

  RxList<NotificationModal> notifications = <NotificationModal>[].obs;

  @override
  void onInit() {
    getNotifications();
    super.onInit();
  }

  getNotifications() async {
    try {
      isLoading.value = true;

      var res = await ApiService.getApi(
          Apis.getNotification(id: AppVariables.box.read(StorageKeys.aId)),
          ctx);

      if (res != null) {
        res['notifications'].forEach((element) {
          notifications.add(NotificationModal.fromJson(element));
        });

        update();
      }
    } catch (e) {
      log(e.toString());
      ShowToast.showFailedGfToast(msg: "Error", ctx: ctx);
    } finally {
      isLoading.value = false;
    }
  }
}

