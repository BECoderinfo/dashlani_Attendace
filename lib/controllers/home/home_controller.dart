import 'package:attendance_app/modals/activity/activity_model.dart';
import 'package:attendance_app/modals/home/dashboardModel.dart';

import '../../services/api_service.dart';
import '../../utils/import.dart';

class HomeController extends GetxController {
  final BuildContext ctx;

  HomeController({required this.ctx});

  // Observables for check-in and check-out times
  var checkInTime = ''.obs;
  var checkOutTime = ''.obs;

  RxBool isGettingActivity = false.obs;

  RxBool isIn = false.obs;

  RxBool isLoading = false.obs;

  RxBool isCreated = false.obs;

  Rx<dashModal> dashModel = dashModal().obs;

  RxBool creatingActivity = false.obs;

  TextEditingController activityController = TextEditingController();

  RxList<ActivityModel> activityList = <ActivityModel>[].obs;

  // Current time, updated every second
  var currentTime = ''.obs;

  // Timer to update the current time
  late final _timer;

  @override
  void onInit() {
    super.onInit();
    DateTime now = DateTime.now();
    String? date = AppVariables.box.read(StorageKeys.date);
    if (date == null || date != DateFormat('hh:mm a').format(now)) {
      isIn.value = false;
    } else {
      isIn.value = AppVariables.box.read(StorageKeys.activity);
    }
    getTodayData();
    getActivity();
  }

  @override
  void onClose() {
    _timer.cancel(); // Stop the timer when the controller is destroyed
    super.onClose();
  }

  Future<void> refreshScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    getTodayData();
    getActivity();
  }

  // Method to check in
  void checkIn() async {
    try {
      var response = await ApiService.postApi(
        Apis.checkIn(id: AppVariables.box.read(StorageKeys.aId)),
        ctx,
        body: {},
      );

      if (response != null) {
        getTodayData();
        isIn.value = true;
        activityController.text = 'Check In';
        createActivity();
      }
    } catch (e) {
      isLoading.value = false;
      update();
      ShowToast.showFailedGfToast(msg: "Check In Failed", ctx: ctx);
    } finally {
      isLoading.value = false;
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
        isIn.value = false;
        activityController.text = 'Check Out';
        createActivity();
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

  void inOut() {
    if (isIn.value) {
      createActivity();
    } else {
      showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        // ✅ Enables full height and keyboard-friendly behavior
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              top: 20,
              right: 16,
              left: 16,
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // ✅ Responds to keyboard
            ),
            child: SingleChildScrollView(
              child: Obx(
                () => (isCreated.value)
                    ? Column(
                        children: [
                          const Text("Activity Created"),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              isCreated.value = false;
                              Get.back();
                            },
                            child: const Text("OK"),
                          ),
                          const SizedBox(height: 20),
                        ],
                      )
                    : (creatingActivity.value)
                        ? const CircularProgressIndicator()
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("Enter reason for check out"),
                              const SizedBox(height: 20),
                              TextField(
                                controller: activityController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Reason',
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  createActivity();
                                },
                                child: const Text("Submit"),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
              ),
            ),
          );
        },
      );
    }
  }

  createActivity() async {
    try {
      creatingActivity.value = true;

      var res = await ApiService.postApi(Apis.activityLog, ctx, body: {
        "userId": AppVariables.box.read(StorageKeys.aId),
        if (activityController.text.isNotEmpty)
          "title": activityController.text,
        if (activityController.text.isEmpty)
          "title": isIn.value ? "back to work" : "going out",
        "activityType": isIn.value ? "In" : "Out"
      });

      if (res != null) {
        isCreated.value = true;
        activityController.clear();
        isIn.value = !isIn.value;
        AppVariables.box.write(StorageKeys.activity, isIn.value);
        DateTime now = DateTime.now();
        String? date = AppVariables.box.read(StorageKeys.date);

        if (date == null || date != DateFormat('hh:mm a').format(now)) {
          AppVariables.box
              .write(StorageKeys.date, DateFormat('hh:mm a').format(now));
        }
        getActivity();
      }
    } catch (e) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Activity Log Failed.',
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      creatingActivity.value = false;
    }
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

  getActivity() async {
    try {
      isGettingActivity.value = true;
      var response = await ApiService.getApi(
        "${Apis.activity}/${AppVariables.box.read(StorageKeys.aId)}",
        ctx,
      );

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
      isGettingActivity.value = false;
    }
  }
}
