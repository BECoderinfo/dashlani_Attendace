import 'dart:ffi';

import 'package:attendance_app/modals/home/dashboardModel.dart';

import '../../services/api_service.dart';
import '../../utils/import.dart';

class HomeController extends GetxController {
  final BuildContext ctx;

  HomeController({required this.ctx});

  // Observables for check-in and check-out times
  var checkInTime = ''.obs;
  var checkOutTime = ''.obs;

  RxBool isLoading = false.obs;

  Rx<dashModal> dashModel = dashModal().obs;

  // Current time, updated every second
  var currentTime = ''.obs;

  // Timer to update the current time
  late final _timer;

  @override
  void onInit() {
    super.onInit();
    getTodayData();
  }

  @override
  void onClose() {
    _timer.cancel(); // Stop the timer when the controller is destroyed
    super.onClose();
  }

  Future<void> refreshScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    getTodayData();
  }

  // Method to check in
  void checkIn() async {
    try {
      var response = await ApiService.postApi(
        Apis.checkIn(id: AppVariables.box.read(StorageKeys.aId)),
        ctx,
      );

      if (response != null) {
        getTodayData();
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      update();
      ShowToast.showFailedGfToast(msg: "Check In Failed", ctx: ctx);
    }
  }

  // Method to check out
  void checkOut() async {
    try {
      isLoading.value = true;
      var response = await ApiService.putApi(
        Apis.checkOut(id: AppVariables.box.read(StorageKeys.aId)),
        ctx,
      );

      if (response != null) {
        getTodayData();
      }
      update();
    } catch (e) {
      isLoading.value = false;
      update();
      ShowToast.showFailedGfToast(msg: "Check Out Failed", ctx: ctx);
    } finally {
      isLoading.value = false;
    }
  }

  // Get the current formatted time
  String getFormattedTime(DateTime date) {
    // print(DateTime.now());
    return DateFormat('hh:mm a').format(date);
  }

  getTodayData() async {
    try {
      isLoading.value = true;

      var response = await ApiService.getApi(
        Apis.dashboard(id: AppVariables.box.read(StorageKeys.aId)),
        ctx,
      );

      if (response['success'] == true) {
        dashModel.value = dashModal.fromJson(response);
        update();
      }
      update();
    } catch (e) {
      isLoading.value = false;
      update();
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
