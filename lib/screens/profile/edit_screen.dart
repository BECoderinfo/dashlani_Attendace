import 'package:attendance_app/controllers/profile/edit_profile_controller.dart';
import 'package:attendance_app/utils/import.dart';
import 'package:flutter/cupertino.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    EditProfileController controller =
        Get.put(EditProfileController(ctx: context));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Gap(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: const Icon(CupertinoIcons.back),
                  onTap: () {
                    Get.back();
                  },
                ),
                const Text(
                  'Edit Profile',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.blackColor),
                ),
                const Gap(10),
              ],
            ),
            const Gap(40),
            Form(
              child: Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.nameController,
                      decoration: const InputDecoration(
                        label: Text(
                          'Name',
                          style: TextStyle(
                            color: AppColors.iconColor,
                          ),
                        ),
                      ),
                    ),
                    const Gap(20),
                    TextFormField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                        label: Text(
                          'Email Address',
                          style: TextStyle(
                            color: AppColors.iconColor,
                          ),
                        ),
                      ),
                    ),
                    const Gap(20),
                    TextFormField(
                      controller: controller.phoneController,
                      decoration: const InputDecoration(
                        label: Text(
                          'Phone Number',
                          style: TextStyle(
                            color: AppColors.iconColor,
                          ),
                        ),
                      ),
                    ),
                    const Gap(20),
                    TextFormField(
                      controller: controller.addressController,
                      decoration: const InputDecoration(
                        label: Text(
                          'Address',
                          style: TextStyle(
                            color: AppColors.iconColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(
        () => GestureDetector(
          onTap: controller.isLoading.value
              ? null
              : () {
                  controller.updateData();
                },
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.iconColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: (controller.isLoading.value)
                ? const CircularProgressIndicator(
                    color: AppColors.whiteColor,
                  )
                : const Text(
                    'Update',
                    style: TextStyle(color: AppColors.whiteColor, fontSize: 18),
                  ),
          ),
        ),
      ),
    );
  }
}
