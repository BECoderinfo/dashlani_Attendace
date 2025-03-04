class Apis {
  static const Duration timeoutDuration = Duration(minutes: 5);
  static const Map<String, String> headersValue = {
    'Content-Type': 'application/json'
  };
  static const String serverAddress =
      "https://dashlani-attendance.onrender.com";

  // static const String serverAddress =
  //     "https://dashlani-attendance-production.up.railway.app";

  /// authentication endpoints
  static const String login = "$serverAddress/users/login";
  static const String security = "$serverAddress/users/sequre";
  static const String forgetPassword = "$serverAddress/users/sendotp";
  static const String otpVerification = "$serverAddress/users/otpverify";
  static const String changePass = "$serverAddress/admin/changepassword";

  static const String signUp = "$serverAddress/users/create";

  static const String logout = "$serverAddress/token/delete";

  /// token endpoints
  static const String saveToken = "$serverAddress/token/save";

  /// get employee details
  static const String employee = "$serverAddress/employee";

  static String getById({required String id}) => "$serverAddress/users/get/$id";

  /// today attendance
  static String dashboard({required String id}) =>
      "$serverAddress/users/dashboard/$id";

  /// check in and check out
  static String checkIn({required String id}) =>
      "$serverAddress/attendance/checkin/$id";

  /// check in and check out
  static String checkOut({required String id}) =>
      "$serverAddress/attendance/checkout/$id";

  /// update profile
  static String updateProfile({required String id}) =>
      "$serverAddress/users/update/$id";

  /// get downloads
  static String download({required String id}) =>
      "$serverAddress/document/getall/$id";

  /// terms and conditions
  static const String getTerms = "$serverAddress/rules/getall";

  /// leave request
  static String leaveRequest = "$serverAddress/leave/apply";

  static String editLeaveRequest({required String id}) =>
      "$serverAddress/leave/update/$id";

  static String getLeaves({required id}) => "$serverAddress/leave/user/$id";

  /// attendance history
  static String attendanceHistory({required String id}) =>
      "$serverAddress/attendance/mmrecord/$id";

  static const String getHoliday = "$serverAddress/holiday/getHolidays";

  static const String getTermsAndConditions = "$serverAddress/tandc/get";

  static const String getPrivacyPolicy = "$serverAddress/policy/get";

  static const String changePassword = "$serverAddress/users/resetpassword";

  static String getNotification({required String id}) =>
      "$serverAddress/notification/user/$id";
}
