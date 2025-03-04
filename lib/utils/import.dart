export 'dart:io' show File, SocketException, InternetAddress, HttpClient;
export 'dart:async' show TimeoutException, Timer, Completer;
export 'dart:convert' show jsonEncode, jsonDecode, utf8, json;
export 'package:flutter/material.dart';
export 'package:flutter/services.dart'
    show SystemNavigator, MethodChannel, PlatformException, rootBundle;
export 'dart:developer' show log;
export 'dart:typed_data' show Uint8List;

/// utils
export 'package:attendance_app/utils/theme.dart';
export 'package:attendance_app/utils/app_colors.dart';
export 'package:attendance_app/utils/app_variables.dart';
export 'package:attendance_app/utils/show_toast.dart';
export 'package:attendance_app/utils/app_assets.dart';
export 'package:attendance_app/utils/storage_keys.dart';
export 'package:attendance_app/utils/apis.dart';

/// packages
export 'package:get/get.dart';
export 'package:get_storage/get_storage.dart';
export 'package:intl/intl.dart' show DateFormat;
export 'package:flutter_speed_dial/flutter_speed_dial.dart';
export 'package:table_calendar/table_calendar.dart';
export 'package:gap/gap.dart';
export 'package:image_picker/image_picker.dart';
export 'package:flutter_svg/flutter_svg.dart';

/// screens
export '../screens/splash/splash_screen.dart';
export '../screens/login/login_screen.dart';
export '../screens/home/home_screen.dart';
export '../screens/navigation/navigation_screen.dart';
export '../screens/profile/profile_screen.dart';
export 'package:attendance_app/screens/home/attendance_history.dart';
export 'package:attendance_app/screens/leave/create_leave.dart';
export '../screens/profile/edit_screen.dart';
export 'package:attendance_app/screens/note/note.dart';
export 'package:attendance_app/screens/download/downloads.dart';

/// routes
export 'package:attendance_app/routes/app_routes.dart';

/// extensions
export 'package:attendance_app/extension.dart';

/// controllers
export '../controllers/splash/splash_controller.dart';
export '../controllers/login/login_controller.dart';
export '../controllers/home/home_controller.dart';
export '../controllers/navigation/navigation_controller.dart';
export '../controllers/profile/profile_controller.dart';
export '../controllers/leave/create_leave_controller.dart';
export '../controllers/attendance_history/attendance_history_controller.dart';
export '../controllers/note/note_controller.dart';
export '../controllers/downloads/download_controller.dart';

/// widgets
export '../widgets/custom_dialog.dart';
export '../../widgets/dialog.dart';
