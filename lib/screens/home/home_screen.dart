import 'package:easy_date_timeline/easy_date_timeline.dart';
import '../../utils/import.dart';
import '../../widgets/sliding_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController(ctx: context));

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(
                  '${AppVariables.box.read(StorageKeys.aImage)}',
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
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Today Attendance",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Gap(16),
                          Obx(
                            () => Row(
                              children: [
                                Expanded(
                                  child: _GridItemTile(
                                    title: "Check In",
                                    value: controller
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
                                    value: controller
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
                                const Expanded(
                                  child: _GridItemTile(
                                    title: "Break Time",
                                    value: "01:00 hr",
                                    icon: Icons.coffee_sharp,
                                    subtitle: 'Avg Time 1 hr',
                                  ),
                                ),
                                const Gap(16),
                                Expanded(
                                  child: _GridItemTile(
                                    title: "Total Days",
                                    value:
                                        "${controller.dashModel.value.totalAttendances ?? 0}",
                                    icon: Icons.calendar_month,
                                    subtitle: 'Working Days',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(16),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Your Activity",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Gap(16),
                          ListView.builder(
                            padding: const EdgeInsets.all(0),
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  leading: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: AppColors.iconBg,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.calendar_month,
                                      color: AppColors.iconColor,
                                    ),
                                  ),
                                  title: const Text(
                                    'Meeting with Team',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: const Text(
                                    'Meeting with Team',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                ),
                              );
                            },
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
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
            ? const CircularProgressIndicator()
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
