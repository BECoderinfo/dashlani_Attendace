import '../../modals/attendance/attendance_modal.dart';
import '../../services/api_service.dart';
import '../../utils/import.dart';

class AttendanceHistoryController extends GetxController {
  final BuildContext ctx;

  AttendanceHistoryController({required this.ctx});

  RxList<Attendance> attendanceList = <Attendance>[].obs;
  Rxn<Attendance> selectedAttendance = Rxn<Attendance>();

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  Rxn<CalendarFormat?> format = Rxn();

  @override
  void onInit() {
    super.onInit();
    format.value = CalendarFormat.month;
    fetchAttendanceHistory();
  }

  // Fetch all attendance data
  void fetchAttendanceHistory() async {
    try {
      var res = await ApiService.getApi(
        Apis.attendanceHistory(id: AppVariables.box.read(StorageKeys.aId)),
        ctx,
      );
      if (res != null) {
        ShowToast.showSuccessGfToast(
          msg: "Attendance history fetched successfully",
          ctx: ctx,
        );
        attendanceList.value = res['attendance']
            .map<Attendance>((e) => Attendance.fromJson(e))
            .toList();
        updateSelectedAttendance(); // Initialize selected attendance
      }
    } catch (e) {
      ShowToast.showFailedGfToast(msg: e.toString(), ctx: ctx);
    }
  }

  // Update attendance data for selected date
  void updateSelectedAttendance() {
    if (selectedDay != null) {
      selectedAttendance.value = attendanceList.firstWhereOrNull(
            (attendance) {
          if (attendance.date == null) return false;
          DateTime apiDate = DateTime.parse(attendance.date!);
          return apiDate.year == selectedDay!.year &&
              apiDate.month == selectedDay!.month &&
              apiDate.day == selectedDay!.day;
        },
      );
    } else {
      selectedAttendance.value = null;
    }
  }


  // Handle date selection
  void onDateSelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay = selectedDay;
    this.focusedDay = focusedDay;
    updateSelectedAttendance();
    update(); // Update the UI
  }
}
