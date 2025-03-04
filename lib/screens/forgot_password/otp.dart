import 'package:attendance_app/controllers/forgot_password/otp_controller.dart';
import 'package:attendance_app/utils/import.dart';
import 'package:flutter/cupertino.dart';

class Otp extends StatelessWidget {
  const Otp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OtpController(ctx: context));
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
                  'Enter Verification Code 📨',
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
                  'We have sent a verification code to your email address.',
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
                    Expanded(child: SvgPicture.asset(AppAssets.otp)),
                    const Gap(20),
                    CustomOtpInput(
                      fieldWidth: 60,
                      fieldHeight: 60,
                      // spacing: 20,
                      borderColor: AppColors.greyColor,
                      onCompleted: (p0) {
                        controller.otpController.text = p0;
                        log(p0);
                      },
                    ),
                    const Gap(10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: '00:30',
                                style: TextStyle(color: AppColors.blackColor)),
                            TextSpan(
                              text: ' Resend it',
                              style: TextStyle(color: AppColors.iconColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(30),
                    Obx(
                      () => GestureDetector(
                        onTap: controller.isLoading.value
                            ? null
                            : () {
                                controller.otpVerify();
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

class CustomOtpInput extends StatelessWidget {
  final int length;
  final double fieldWidth;
  final double fieldHeight;
  final double spacing;
  final TextStyle? textStyle;
  final Color borderColor;
  final Color focusBorderColor;
  final Color fillColor;
  final double borderRadius;
  final Function(String) onCompleted;

  const CustomOtpInput({
    super.key,
    this.length = 4,
    this.fieldWidth = 50,
    this.fieldHeight = 50,
    this.spacing = 8,
    this.textStyle,
    this.borderColor = Colors.grey,
    this.focusBorderColor = Colors.blue,
    this.fillColor = Colors.white,
    this.borderRadius = 8,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final List<TextEditingController> controllers =
        List.generate(length, (_) => TextEditingController());
    final List<FocusNode> focusNodes =
        List.generate(length, (_) => FocusNode());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(length, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: spacing / 2),
          width: fieldWidth,
          height: fieldHeight,
          alignment: Alignment.center,
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            clipBehavior: Clip.hardEdge,
            maxLength: 1,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: textStyle ??
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              counterText: '',
              // Hide character counter
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: focusBorderColor),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              filled: true,
              fillColor: fillColor,
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < length - 1) {
                focusNodes[index + 1].requestFocus();
              } else if (value.isEmpty && index > 0) {
                focusNodes[index - 1].requestFocus();
              }

              // Check if all fields are filled
              if (controllers
                  .every((controller) => controller.text.isNotEmpty)) {
                onCompleted(
                    controllers.map((controller) => controller.text).join());
              }
            },
          ),
        );
      }),
    );
  }
}
