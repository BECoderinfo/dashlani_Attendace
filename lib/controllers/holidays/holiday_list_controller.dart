import 'package:attendance_app/modals/holiday/holiday_modal.dart';
import 'package:attendance_app/services/api_service.dart';
import 'package:attendance_app/utils/import.dart';

class HolidayListController extends GetxController {
  final BuildContext ctx;

  HolidayListController({required this.ctx});

  RxList<Holiday> holidayList = <Holiday>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getHolidays();
  }

  Future<void> refreshScreen() async {
    await Future.delayed(const Duration(seconds: 1));
    getHolidays();
    update();
  }

  getHolidays() async {
    try {
      isLoading.value = true;

      var res = await ApiService.getApi(Apis.getHoliday, ctx);

      if (res != null) {
        holidayList.clear();
        res['holidays'].forEach((e) {
          holidayList.add(Holiday.fromJson(e));
        });
        holidayList.sort(
          (a, b) {
            return a.startDate.compareTo(b.startDate);
          },
        );
        update();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
