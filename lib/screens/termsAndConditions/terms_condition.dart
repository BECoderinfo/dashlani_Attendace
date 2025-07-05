import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:attendance_app/controllers/termsAndConditions/terms_condition_controller.dart';
import 'package:attendance_app/utils/import.dart';

import 'package:flutter/cupertino.dart';

class TermsCondition extends StatelessWidget {
  const TermsCondition({super.key});

  @override
  Widget build(BuildContext context) {
    TermsConditionController controller =
        Get.put(TermsConditionController(ctx: context));
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
                      child: Icon(
                        CupertinoIcons.back,
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
                const Text(
                  'Terms & Conditions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
                Gap(30),
              ],
            ),
            Flexible(
              child: RefreshIndicator(
                onRefresh: () => controller.refreshScreen(),
                child: ListView(
                  children: [
                    Obx(
                      () => Text(
                          'Last update: ${controller.updatedTermsTime.value}'),
                    ),
                    const Gap(10),
                    const Text(
                      'Please read these terms of service. carefully before using our app operated by us,',
                      style:
                          TextStyle(color: AppColors.blackColor, fontSize: 16),
                    ),
                    const Gap(20),
                    const Text(
                      'Conditions of Uses',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    const Gap(10),
                    Obx(
                      () => controller.isLoading.value == true
                          ? SizedBox(
                              height: 400,
                              child: Center(
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    WavyAnimatedText(
                                      'Loading...',
                                      textStyle: const TextStyle(
                                        color: AppColors.blackColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : (controller.termsCondition.value == "")
                              ? const Text('We are working on it!')
                              : Text(
                                  controller.termsCondition.value,
                                  style: const TextStyle(
                                      color: AppColors.blackColor,
                                      fontSize: 16),
                                ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
