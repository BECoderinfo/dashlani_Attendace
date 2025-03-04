import 'package:attendance_app/screens/access/access_page.dart';
import 'package:attendance_app/screens/forgot_password/forgot_password.dart';
import 'package:attendance_app/screens/forgot_password/new_password.dart';
import 'package:attendance_app/screens/forgot_password/otp.dart';
import 'package:attendance_app/screens/notification/notification.dart';
import 'package:attendance_app/screens/privacy_police/privacy_police.dart';
import 'package:attendance_app/screens/profile/my_profile.dart';
import 'package:attendance_app/screens/settings/change_password.dart';
import 'package:attendance_app/screens/settings/settings.dart';
import 'package:attendance_app/screens/signup/signup.dart';
import 'package:attendance_app/screens/termsAndConditions/terms_condition.dart';

import '../screens/leave/leave_details.dart';
import '../utils/import.dart';

class AppPages {
  AppPages._();

  // static const initialRoute = Routes.loginScreen;

  static const initialRoute = Routes.splashScreen;

  static final routes = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.loginScreen,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.signup,
      page: () => const Signup(),
    ),
    GetPage(
      name: Routes.forgotPassword,
      page: () => const ForgotPassword(),
    ),
    GetPage(
      name: Routes.otp,
      page: () => const Otp(),
    ),
    GetPage(
      name: Routes.newPassword,
      page: () => const NewPassword(),
    ),
    GetPage(
      name: Routes.homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: Routes.navigation,
      page: () => const NavigationScreen(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const MyProfile(),
    ),
    GetPage(
      name: Routes.applyLeave,
      page: () => const CreateLeave(),
    ),
    GetPage(
      name: Routes.leaveDetails,
      page: () => const LeaveDetails(),
    ),
    GetPage(
      name: Routes.attendanceHistory,
      page: () => const AttendanceHistory(),
    ),
    GetPage(
      name: Routes.note,
      page: () => const Note(),
    ),
    GetPage(
      name: Routes.downloads,
      page: () => const Downloads(),
    ),
    GetPage(
      name: Routes.termsAndConditions,
      page: () => const TermsCondition(),
    ),
    GetPage(
      name: Routes.notification,
      page: () => const Notifications(),
    ),
    GetPage(
      name: Routes.privacyPolice,
      page: () => const PrivacyPolice(),
    ),
    GetPage(
      name: Routes.settings,
      page: () => const Setting(),
    ),
    GetPage(
      name: Routes.editProfile,
      page: () => const EditProfile(),
    ),
    GetPage(
      name: Routes.accessPage,
      page: () => const AccessPage(),
    ),
    GetPage(
      name: Routes.changePassword,
      page: () => const ChangePassword(),
    ),
  ];
}
