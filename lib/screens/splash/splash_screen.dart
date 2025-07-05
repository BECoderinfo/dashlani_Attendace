import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/import.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.secondaryColor,
          body: Center(
            child: DefaultTextStyle(
              style: GoogleFonts.gideonRoman(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  FadeAnimatedText('Dashlani\nTechnology',
                      textAlign: TextAlign.center),
                ],
                onTap: () {
                  print("Tap Event");
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
