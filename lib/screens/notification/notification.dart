import 'package:attendance_app/controllers/notification/notification_controller.dart';
import 'package:attendance_app/utils/import.dart';
import 'package:flutter/cupertino.dart';

import '../../modals/notification/notification_modal.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationController controller =
        Get.put(NotificationController(ctx: context));
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Gap(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  child: const Icon(CupertinoIcons.back),
                  onTap: () {
                    Get.back();
                  },
                ),
                const Text(
                  'Notification',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.blackColor,
                  ),
                ),
                Gap(30),
              ],
            ),
            const Gap(20),
            Obx(
              () => Flexible(
                child: controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : controller.notifications.isEmpty
                        ? const Center(child: Text('No Notification'))
                        : ListView.builder(
                            padding: const EdgeInsets.all(0),
                            itemBuilder: (BuildContext context, int index) {
                              NotificationModal notification =
                                  controller.notifications[index];
                              return NotificationTile(
                                  icon: notification.resiveModel == "Admin"
                                      ? Icons.person
                                      : Icons.group,
                                  title: notification.title,
                                  description: notification.description!,
                                  date: DateFormat('yyyy-MM-dd')
                                      .format(notification.createdAt));
                            },
                            itemCount: controller.notifications.length,
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final String description;
  final IconData? icon;
  final String? image;
  final String date;

  const NotificationTile({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    this.icon,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.iconBg,
              radius: 25,
              child: icon != null
                  ? Icon(
                      icon,
                      color: AppColors.iconColor,
                      size: 26,
                    )
                  : Image.asset(
                      image!,
                      width: 30,
                      height: 30,
                    ),
            ),
            const Gap(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.blackColor,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.blackColor,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.greyColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Gap(10),
        const Divider(
          color: AppColors.bgColor,
        ),
      ],
    );
  }
}
