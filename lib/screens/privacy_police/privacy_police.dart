import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:attendance_app/controllers/privacy_police/privacy_police_controller.dart';
import 'package:attendance_app/utils/import.dart';

import 'package:flutter/cupertino.dart';

class PrivacyPolice extends StatelessWidget {
  const PrivacyPolice({super.key});

  @override
  Widget build(BuildContext context) {
    PrivacyPoliceController controller =
        Get.put(PrivacyPoliceController(ctx: context));
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
                  'Privacy Police',
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
                    Obx(() => Text(
                        'Last update: ${controller.updatedPrivacyTime.value}')),
                    const Gap(10),
                    const Text(
                      'Please read these privacy policy. carefully before using our app operated by us,',
                      style:
                          TextStyle(color: AppColors.blackColor, fontSize: 16),
                    ),
                    const Gap(20),
                    const Text(
                      'Privacy Police',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.iconColor,
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
                          : (controller.privacyPolicy.value == "")
                              ? const Text('We are working on it!')
                              : Text(
                                  controller.privacyPolicy.value,
                                  style: const TextStyle(
                                    color: AppColors.blackColor,
                                    fontSize: 16,
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
    );
  }
}
