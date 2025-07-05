import 'package:attendance_app/controllers/change_password/chanege_%20password_controller.dart';
import 'package:attendance_app/utils/import.dart';
import 'package:flutter/cupertino.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    ChangePasswordController controller =
        Get.put(ChangePasswordController(ctx: context));
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
                  child: const SizedBox(
                    height: 30,
                    width: 30,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(CupertinoIcons.back),
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
                const Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
                const Gap(30),
              ],
            ),
            const Gap(30),
            Expanded(
              child: Form(
                key: controller.formKey,
                child: Obx(
                  () => Column(
                    children: [
                      TextFormField(
                        controller: controller.oldPasswordController,
                        decoration: InputDecoration(
                          label: const Text('Old Password'),
                          labelStyle: const TextStyle(
                            color: AppColors.iconColor,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(controller.oldPasswordVisible.value
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              controller.oldPasswordVisible.value =
                                  !controller.oldPasswordVisible.value;
                            },
                          ),
                        ),
                        obscureText: controller.oldPasswordVisible.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your old password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const Gap(10),
                      TextFormField(
                        controller: controller.newPasswordController,
                        decoration: InputDecoration(
                          label: const Text('New Password'),
                          labelStyle: const TextStyle(
                            color: AppColors.iconColor,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(controller.newPasswordVisible.value
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              controller.newPasswordVisible.value =
                                  !controller.newPasswordVisible.value;
                            },
                          ),
                        ),
                        obscureText: controller.newPasswordVisible.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your new password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const Gap(10),
                      TextFormField(
                        decoration: InputDecoration(
                          label: const Text('Confirm Password'),
                          labelStyle: const TextStyle(
                            color: AppColors.iconColor,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(controller.confirmPasswordVisible.value
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              controller.confirmPasswordVisible.value =
                                  !controller.confirmPasswordVisible.value;
                            },
                          ),
                        ),
                        obscureText: controller.confirmPasswordVisible.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your confirm password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          } else if (value !=
                              controller.newPasswordController.text) {
                            return 'Password does not match';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
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
                  controller.updatePassword();
                },
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 58,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: controller.isLoading.value
                ? const CircularProgressIndicator()
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
