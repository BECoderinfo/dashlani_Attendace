import 'package:attendance_app/modals/leave/leaveModal.dart';
import 'package:attendance_app/services/api_service.dart';
import 'package:attendance_app/utils/import.dart';

class LeaveController extends GetxController {
  RxInt currentTab = 0.obs;
  final BuildContext ctx;

  LeaveController({required this.ctx});

  RxBool isLoading = false.obs;

  RxInt totalLeaves = 0.obs;
  RxInt totalPendingLeaves = 0.obs;
  RxInt totalApprovedLeaves = 0.obs;
  RxInt totalRejectedLeaves = 0.obs;

  RxList<LeaveModal> pastLeaves = <LeaveModal>[].obs;
  RxList<LeaveModal> upcomingLeaves = <LeaveModal>[].obs;

  @override
  void onInit() {
    super.onInit();
    getLeaves();
  }

  Future<void> refreshScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    getLeaves();
  }

  void changeTab({required int index}) {
    currentTab.value = index;
  }

  void getLeaves() async {
    try {
      isLoading.value = true;

      var res = await ApiService.getApi(
          Apis.getLeaves(id: AppVariables.box.read(StorageKeys.aId)), ctx);

      if (res != null) {
        totalLeaves.value = 0;
        totalPendingLeaves.value = 0;
        totalApprovedLeaves.value = 0;
        totalRejectedLeaves.value = 0;
        // Clear existing lists
        pastLeaves.clear();
        upcomingLeaves.clear();

        DateTime today = DateTime.now();

        res['leaves'].forEach((e) {
          totalLeaves.value++;
          // Extract start and end dates
          // Convert to DateTime
          DateTime endDate = DateTime.parse(e['endDate']);
          DateTime startDate = DateTime.parse(e['startDate']);

          // Create LeaveModal instance
          LeaveModal leave = LeaveModal.fromJson(e);
          if (endDate.isBefore(today)) {
            if (e['status'] == "Pending") totalPendingLeaves.value++;
            if (e['status'] == "Approved") totalApprovedLeaves.value++;
            if (e['status'] == "Rejected") totalRejectedLeaves.value++;
            pastLeaves.add(leave);
          } else if (endDate.isAfter(today)) {
            if (e['status'] == "Pending") totalPendingLeaves.value++;
            if (e['status'] == "Approved") totalApprovedLeaves.value++;
            if (e['status'] == "Rejected") {
              totalRejectedLeaves.value++;
            }
            upcomingLeaves.add(leave);
          }

          pastLeaves.refresh();
          upcomingLeaves.refresh();
        });
      }
    } catch (e) {
      log(e.toString());
      ShowToast.showFailedGfToast(msg: e.toString(), ctx: ctx);
    } finally {
      isLoading.value = false;
    }
  }
}
