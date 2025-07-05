import 'package:attendance_app/controllers/home/Activity_controller.dart';

import '../../modals/activity/activity_model.dart';
import '../../utils/import.dart';

class AllAvtivity extends StatelessWidget {
  const AllAvtivity({super.key});

  @override
  Widget build(BuildContext context) {
    ActivityController controller = Get.put(ActivityController(ctx: context));
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Activity'),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.refreshScreen(),
        child: Obx(
          () => (controller.isLoading.value)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : (controller.activityList.isEmpty)
                  ? const Center(child: Text('No Activity Today'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: controller.activityList.length,
                      itemBuilder: (context, index) {
                        ActivityModel activity = controller.activityList[index];
                        return Card(
                          child: ListTile(
                            leading: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: AppColors.iconBg,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                (activity.activityType == 'In')
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
                    ),
        ),
      ),
    );
  }
}
