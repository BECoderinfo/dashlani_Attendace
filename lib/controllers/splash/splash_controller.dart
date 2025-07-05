import 'package:firebase_messaging/firebase_messaging.dart';

import '../../main.dart';
import '../../utils/import.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    FirebaseMessaging.onMessage.listen(
      (event) {
        showFlutterNotification(event);
      },
    );

    6.delay().then(
      (value) {
        if (AppVariables.box.read(StorageKeys.isLoggedIn) ?? false) {
          if (AppVariables.box.read(StorageKeys.access) ?? false) {
            (Routes.navigation).offAllNamed();
          } else {
            (Routes.accessPage).offAllNamed();
          }
        } else {
          (Routes.loginScreen).offAllNamed();
        }
      },
    );
  }
}
