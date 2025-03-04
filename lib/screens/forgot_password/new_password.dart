import 'package:attendance_app/controllers/forgot_password/new_password_controller.dart';
import 'package:attendance_app/utils/import.dart';
import 'package:flutter/cupertino.dart';

class NewPassword extends StatelessWidget {
  const NewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    NewPasswordController controller =
        Get.put(NewPasswordController(ctx: context));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              const Gap(40),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    CupertinoIcons.back,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
              const Gap(30),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter New Password 🔑',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
              const Gap(10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "If you Forgot your password, you can reset it here any time.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
              const Gap(20),
              Expanded(
                child: Column(
                  children: [
                    Expanded(child: SvgPicture.asset(AppAssets.newPassword)),
                    const Gap(20),
                    Obx(
                      () => TextFormField(
                        controller: controller.newPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Enter New Password',
                          hintText: 'Enter New Password',
                          suffixIcon: IconButton(
                            icon: Icon(controller.isPasswordHidden.value
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: controller.isPasswordHidden.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password.';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const Gap(16),
                    Obx(
                      () => TextFormField(
                        controller: controller.cPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Re-Enter Password',
                          hintText: 'Re-Enter Password',
                          suffixIcon: IconButton(
                            icon: Icon(controller.isCPasswordHidden.value
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye),
                            onPressed: controller.toggleCPasswordVisibility,
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: controller.isCPasswordHidden.value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please re-enter your password.';
                          } else if (value !=
                              controller.newPasswordController.text) {
                            return 'Passwords do not match.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const Gap(30),
                    Obx(
                      () => GestureDetector(
                        onTap: controller.isLoading.value
                            ? null
                            : () {
                                controller.updatePassword();
                              },
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.iconColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: controller.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: AppColors.whiteColor,
                                  )
                                : const Text(
                                    'Continue',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const Gap(10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
