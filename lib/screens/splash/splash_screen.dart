import '../../utils/import.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Image.asset(
          AppAssets.splash,
          fit: BoxFit.fill,
        );
      },
    );
  }
}
