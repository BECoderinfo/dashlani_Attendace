import 'package:flutter/cupertino.dart';

import '../../utils/import.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController(ctx: context));

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: RefreshIndicator(
          onRefresh: () => controller.refreshScreen(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(40),
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Obx(
                        () => controller.isLoading.value
                            ? const CircleAvatar(
                                radius: 50,
                                backgroundColor: AppColors.iconColor,
                                child: CircularProgressIndicator(
                                  color: AppColors.whiteColor,
                                ),
                              )
                            : controller.profileImage.value.isEmpty
                                ? const CircleAvatar(
                                    radius: 50,
                                    backgroundColor: AppColors.iconColor,
                                    backgroundImage: NetworkImage(
                                        'https://play-lh.googleusercontent.com/7oW_TFaC5yllHJK8nhxHLQRCvGDE8jYIAc2SWljYpR6hQlFTkbA6lNvER1ZK-doQnQ=w240-h480-rw'),
                                  )
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundColor: AppColors.iconColor,
                                    backgroundImage: NetworkImage(
                                        controller.profileImage.value),
                                  ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            controller.updateProfile();
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: AppColors.iconColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.whiteColor),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              CupertinoIcons.camera_on_rectangle,
                              size: 18,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                Text(
                  '${AppVariables.box.read(StorageKeys.aName)}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                const Gap(6),
                Text(
                  '${AppVariables.box.read(StorageKeys.aRole)}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.blackColor,
                  ),
                ),
                const Gap(20),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.editProfile, arguments: controller.user);
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.iconColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Edit Profile',
                      style:
                          TextStyle(color: AppColors.whiteColor, fontSize: 18),
                    ),
                  ),
                ),
                const Gap(20),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.bgColor,
                    child: Icon(
                      CupertinoIcons.person,
                      color: AppColors.blackColor,
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(Routes.profile, arguments: controller.user);
                  },
                  title: const Text("My Profile"),
                  trailing: const Icon(CupertinoIcons.forward),
                ),
                const Divider(
                  color: AppColors.bgColor,
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.bgColor,
                    child: Icon(
                      Icons.settings_outlined,
                      color: AppColors.blackColor,
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(Routes.settings);
                  },
                  title: const Text("Settings"),
                  trailing: const Icon(CupertinoIcons.forward),
                ),
                const Divider(
                  color: AppColors.bgColor,
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.bgColor,
                    child: Icon(
                      CupertinoIcons.list_bullet_below_rectangle,
                      color: AppColors.blackColor,
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(Routes.termsAndConditions);
                  },
                  title: const Text("Terms & Conditions"),
                  trailing: const Icon(CupertinoIcons.forward),
                ),
                const Divider(
                  color: AppColors.bgColor,
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: const CircleAvatar(
                    backgroundColor: AppColors.bgColor,
                    child: Icon(
                      CupertinoIcons.shield,
                      color: AppColors.blackColor,
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(Routes.privacyPolice);
                  },
                  title: const Text("Privacy Policy"),
                  trailing: const Icon(CupertinoIcons.forward),
                ),
                const Divider(
                  color: AppColors.bgColor,
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: CircleAvatar(
                    backgroundColor: Colors.red.shade50,
                    child: Icon(
                      CupertinoIcons.square_arrow_left,
                      color: Colors.red.shade400,
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => LogoutDialog(
                        onConfirm: () {
                          controller
                              .logout(); // Ensure this function is correctly defined in ProfileController
                        },
                      ),
                    );
                  },
                  title: Text(
                    "Log out",
                    style: TextStyle(color: Colors.red.shade400),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LogoutDialog extends StatelessWidget {
  final VoidCallback? onConfirm;

  const LogoutDialog({super.key, this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Logout',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (onConfirm != null) {
              onConfirm!(); // Execute the logout function
            }
            Get.back(); // Close the dialog
          },
          child: const Text('Logout', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
