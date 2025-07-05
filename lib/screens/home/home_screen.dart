import 'package:attendance_app/modals/activity/activity_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import '../../utils/import.dart';
import '../../widgets/sliding_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController(ctx: context));
    final navController = Get.put(BottomNavController());

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            ListTile(
              leading: GestureDetector(
                onTap: () {
                  navController.selectedIndex.value = 3;
                },
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.secondaryColor,
                  backgroundImage: CachedNetworkImageProvider(
                    '${AppVariables.box.read(StorageKeys.aImage)}',
                  ),
                ),
              ),
              title: Text(
                "${AppVariables.box.read(StorageKeys.aName)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('${AppVariables.box.read(StorageKeys.aRole)}'),
              trailing: IconButton.outlined(
                color: AppColors.blackColor,
                icon: const Icon(Icons.notifications_active_outlined),
                onPressed: () {
                  Get.toNamed(Routes.notification);
                },
              ),
            ),
            EasyDateTimeLine(initialDate: DateTime.now()),
            const Gap(10),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RefreshIndicator(
                    onRefresh: controller.refreshScreen,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.chats);
                            },
                            child: Container(
                              height: 54,
                              width: double.infinity,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Chat",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "You have ",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.blackColor,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "3 new messages",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.secondaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Gap(16),
                          Row(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Today Attendance",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Spacer(),
                              Obx(
                                () => (controller.dashModel.value.checkInTime ==
                                        null)
                                    ? const Gap(0)
                                    : (controller
                                                .dashModel.value.checkOutTime !=
                                            null)
                                        ? const Gap(0)
                                        : GestureDetector(
                                            onTap: () {
                                              controller.inOut();
                                            },
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.cached,
                                                  size: 20,
                                                ),
                                                const Gap(8),
                                                Obx(
                                                  () => Text(
                                                    controller.isIn.value
                                                        ? "In"
                                                        : "Out",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: controller
                                                                .isIn.value
                                                            ? AppColors
                                                                .greenColor
                                                            : AppColors
                                                                .redColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                              ),
                            ],
                          ),
                          const Gap(16),
                          Obx(
                            () => Row(
                              children: [
                                Expanded(
                                  child: _GridItemTile(
                                    title: "Check In",
                                    value: controller.isLoading.value
                                        ? "..."
                                        : controller
                                                .dashModel.value.checkInTime ??
                                            "Non",
                                    icon: Icons.login,
                                    subtitle: 'On Time',
                                  ),
                                ),
                                const Gap(16),
                                Expanded(
                                  child: _GridItemTile(
                                    title: "Check Out",
                                    value: controller.isLoading.value
                                        ? "..."
                                        : controller
                                                .dashModel.value.checkOutTime ??
                                            "Non",
                                    icon: Icons.logout,
                                    subtitle: 'Go Home',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(16),
                          Obx(
                            () => Row(
                              children: [
                                Expanded(
                                  child: _GridItemTile(
                                    title: "Break Time",
                                    value: controller.isLoading.value
                                        ? "..."
                                        : "01:00 hr",
                                    icon: Icons.coffee_sharp,
                                    subtitle: 'Avg Time 1 hr',
                                  ),
                                ),
                                const Gap(16),
                                Expanded(
                                  child: _GridItemTile(
                                    title: "Total Days",
                                    value: controller.isLoading.value
                                        ? "..."
                                        : "${controller.dashModel.value.totalAttendances ?? 0}",
                                    icon: Icons.calendar_month,
                                    subtitle: 'Working Days',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(10),
                          Row(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Your Activity",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Spacer(),
                              TextButton(
                                style: TextButton.styleFrom(),
                                onPressed: () {
                                  Get.toNamed(Routes.allActivity);
                                },
                                child: const Text("See All"),
                              ),
                            ],
                          ),
                          // const Gap(16),
                          Obx(
                            () => (controller.isGettingActivity.value)
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : (controller.activityList.isEmpty)
                                    ? const Center(
                                        child: Text('No Activity Today'))
                                    : ListView.builder(
                                        padding: const EdgeInsets.all(0),
                                        itemCount:
                                            controller.activityList.length,
                                        itemBuilder: (context, index) {
                                          ActivityModel activity =
                                              controller.activityList[index];
                                          return Card(
                                            child: ListTile(
                                              leading: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  color: AppColors.iconBg,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Icon(
                                                  (activity.activityType ==
                                                          'In')
                                                      ? Icons.login
                                                      : Icons.logout,
                                                  color: AppColors.iconColor,
                                                ),
                                              ),
                                              title: Text(
                                                "${activity.activityType} / Time: ${activity.createdAt.formatTimeStringInIndia()}",
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              subtitle: Text(
                                                activity.title ?? 'Non',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: AppColors.greyColor,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                      ),
                          ),
                          const Gap(40),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(
        () => controller.isLoading.value
            ? const SizedBox.shrink()
            : controller.dashModel.value.checkInTime == null
                ? SwipeButton(
                    backgroundColor: AppColors.secondaryColor,
                    textStyle: const TextStyle(color: AppColors.whiteColor),
                    buttonColor: AppColors.whiteColor,
                    text: 'Swipe to Check In',
                    onSwipeComplete: () {
                      controller.checkIn();
                    },
                  )
                : controller.dashModel.value.checkOutTime == null
                    ? SwipeButton(
                        backgroundColor: AppColors.secondaryColor,
                        textStyle: const TextStyle(color: AppColors.whiteColor),
                        buttonColor: AppColors.whiteColor,
                        text: 'Swipe to Check Out',
                        onSwipeComplete: () {
                          controller.checkOut();
                        },
                      )
                    : const SizedBox.shrink(),
      ),
    );
  }
}

extension DateTimeExtensions on DateTime {
  String formatTimeStringInIndia() {
    // IST is UTC +5:30
    final istTime = toUtc().add(const Duration(hours: 5, minutes: 30));
    return DateFormat('hh:mm a').format(istTime);
  }
}

class _GridItemTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final String subtitle;
  final VoidCallback? onTap;

  const _GridItemTile({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.iconBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.iconColor,
                  ),
                ),
                const Gap(10),
                Text(title),
              ],
            ),
            const Gap(10),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Gap(10),
            Text(subtitle),
          ],
        ),
      ),
    );
  }
}
