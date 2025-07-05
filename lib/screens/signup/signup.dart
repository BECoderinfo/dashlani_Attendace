import 'package:attendance_app/controllers/signup/signup.dart';
import 'package:attendance_app/utils/import.dart';
import 'package:flutter/cupertino.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    SignupController controller = Get.put(SignupController(ctx: context));
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.key,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(40),
                const Text(
                  'Register Account',
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
                const Gap(4),
                const Text(
                  'Hello there, Register to continue',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const Gap(24),
                TextFormField(
                  controller: controller.firstName,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    hintText: 'Enter First Name',
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter first name';
                    return null;
                  },
                ),
                const Gap(16),
                TextFormField(
                  controller: controller.lastName,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    hintText: 'Enter Last Name',
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter last name';
                    return null;
                  },
                ),
                const Gap(16),
                TextFormField(
                  controller: controller.email,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    hintText: 'Enter Email Address',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter email address';
                    if (!value.isEmail) return 'Please enter valid email';
                    return null;
                  },
                ),
                const Gap(16),
                Obx(
                  () => TextFormField(
                    controller: controller.password,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter password',
                      // prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(controller.isPasswordHidden.value
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                    obscureText: controller.isPasswordHidden.value,
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter password';
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    // validator: controller.validatePassword,
                  ),
                ),
                const Gap(16),
                Obx(
                  () => TextFormField(
                      controller: controller.cPassword,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm password',
                        // prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(controller.isCPasswordHidden.value
                              ? CupertinoIcons.eye_slash
                              : CupertinoIcons.eye),
                          onPressed: controller.toggleCPasswordVisibility,
                        ),
                      ),
                      obscureText: controller.isCPasswordHidden.value,
                      validator: (value) {
                        if (value!.isEmpty) return 'Please enter password';
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        if (value != controller.password.text) {
                          return 'Password does not match';
                        }
                        return null;
                      }
                      // validator: controller.validatePassword,
                      ),
                ),
                const Gap(2),
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.checkBox.value,
                        onChanged: (value) {
                          controller.checkBox.value = value!;
                        },
                      ),
                    ),
                    const Text('I agree to the Terms and Conditions'),
                  ],
                ),
                const Gap(6),
                Obx(
                  () => InkWell(
                    onTap: () => !controller.checkBox.value
                        ? null
                        : controller.isLoading.value
                            ? null
                            : controller.signUp(),
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: controller.checkBox.value
                            ? AppColors.secondaryColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
