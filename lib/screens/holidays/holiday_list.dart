import 'package:attendance_app/controllers/holidays/holiday_list_controller.dart';
import 'package:attendance_app/utils/import.dart';
import 'package:attendance_app/widgets/shimmerLoding.dart';
import 'package:flutter/cupertino.dart';

class HolidayList extends StatelessWidget {
  const HolidayList({super.key});

  @override
  Widget build(BuildContext context) {
    HolidayListController controller =
        Get.put(HolidayListController(ctx: context));
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(40),
            const Text(
              'Holiday List',
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // ListView does not require Expanded
            Obx(
              () => Flexible(
                child: RefreshIndicator(
                  onRefresh: () {
                    return controller.refreshScreen();
                  },
                  child: controller.isLoading.value
                      ? ListView.builder(
                          padding: const EdgeInsets.only(top: 16.0),
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return ShimmerLoading(
                              isLoading: controller.isLoading.value,
                              child: const HolidayTile(
                                title: '',
                                date: '',
                                day: '',
                                isPassed: false,
                                isLoading: true,
                              ),
                            );
                          },
                        )
                      : (controller.holidayList.isEmpty)
                          ? const Center(
                              child: Text('No holidays found'),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.only(top: 16.0),
                              itemCount: controller.holidayList.length,
                              itemBuilder: (BuildContext context, int index) {
                                final holiday = controller.holidayList[index];

                                return HolidayTile(
                                  title: holiday.title,
                                  date: (holiday.endDate != null)
                                      ? '${DateFormat("MMM d, yyyy").format(holiday.startDate)} - ${DateFormat("MMM d, yyyy").format(holiday.endDate!)}'
                                      : DateFormat("MMM d, yyyy")
                                          .format(holiday.startDate),
                                  day: DateFormat('EEE')
                                      .format(holiday.startDate),
                                  // 'Tuesday', // Fixed typo
                                  isPassed: (holiday.startDate
                                          .isBefore(DateTime.now()))
                                      ? true
                                      : false,
                                );
                              },
                            ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HolidayTile extends StatelessWidget {
  final String title;
  final String date;
  final String day;
  final bool isPassed;
  final bool isLoading = false;

  const HolidayTile({
    super.key,
    required this.title,
    required this.date,
    required this.day,
    bool isLoading = false,
    required this.isPassed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      // Updated to make it responsive
      margin: const EdgeInsets.symmetric(vertical: 8),
      // Add vertical spacing between tiles
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left vertical color bar
          Container(
            width: 10,
            height: double.infinity,
            decoration: BoxDecoration(
              color: isPassed ? AppColors.iconBg : AppColors.secondaryColor,
              // Color based on status
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // Align date and day
                    children: [
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.calendar_today,
                            color: AppColors.blackColor,
                          ),
                          const Gap(10),
                          Text(
                            date,
                            style: const TextStyle(color: AppColors.blackColor),
                          ),
                        ],
                      ),
                      Text(
                        day,
                        style: const TextStyle(color: AppColors.greyColor),
                      ),
                    ],
                  ),
                  const Gap(10),
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
