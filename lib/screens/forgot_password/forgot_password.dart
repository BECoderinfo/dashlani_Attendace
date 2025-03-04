import 'package:attendance_app/controllers/forgot_password/forgot_password_controller.dart';
import 'package:attendance_app/utils/import.dart';
import 'package:flutter/cupertino.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController(ctx: context));
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
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
                  'Forgot Password 🤔',
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
                  'Please enter your email address and we will send you a code to reset your password.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
              const Gap(20),
              Expanded(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Expanded(
                          child: SvgPicture.asset(AppAssets.forgotPassword)),
                      const Gap(20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                          hintText: 'Enter Email Address',
                        ),
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address.';
                          } else if (!GetUtils.isEmail(value)) {
                            return 'Please enter a valid email address.';
                          }
                          return null;
                        },
                      ),
                      const Gap(30),
                      Obx(
                        () => GestureDetector(
                          onTap: controller.isLoading.value
                              ? null
                              : () {
                                  controller.submit();
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
