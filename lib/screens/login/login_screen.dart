import 'package:flutter/cupertino.dart';

import '../../utils/import.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(ctx: context),
      builder: (controller) {
        return GestureDetector(
          onTap: () => context.unFocus(),
          // Dismiss keyboard when tapping outside
          child: WillPopScope(
            onWillPop: () async {
              final exit = await CustomDialog().showExitDialog(context);
              return exit;
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: controller.formKey, // Add form key for validation
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(40),
                      const Text(
                        'Welcome Back 👋',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF022159),
                        ),
                      ),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'to ',
                              style: TextStyle(
                                color: Color(0xFF022159),
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: 'Dashlani Community',
                              style: TextStyle(
                                color: AppColors.iconColor,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Hello there, login to continue',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: controller.emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                          hintText: 'Enter your email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: controller.validateEmail,
                      ),
                      const Gap(16),
                      Obx(
                        () => TextFormField(
                          controller: controller.passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            // prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(controller.isPasswordHidden.value
                                  ? CupertinoIcons.eye_slash
                                  : CupertinoIcons.eye),
                              onPressed: controller.togglePasswordVisibility,
                            ),
                          ),
                          obscureText: controller.isPasswordHidden.value,
                          validator: controller.validatePassword,
                        ),
                      ),
                      const Gap(10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.forgotPassword);
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(color: AppColors.secondaryColor),
                          ),
                        ),
                      ),
                      const Gap(24),
                      Obx(
                        () => GestureDetector(
                          onTap: controller.login,
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: controller.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          GestureDetector(
                            onTap: controller.navigateToSignUp,
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                color: AppColors.secondaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
