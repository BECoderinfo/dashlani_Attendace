import 'dart:developer';

import 'package:attendance_app/routes/app_routes.dart';
import 'package:attendance_app/utils/app_variables.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../services/api_service.dart';
import '../../utils/apis.dart';
import '../../utils/storage_keys.dart';

class LoginController extends GetxController {
  final BuildContext ctx;

  LoginController({required this.ctx});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordHidden = true.obs;
  String token = '';

  RxBool isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!GetUtils.isEmail(value)) return 'Enter a valid email';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      // Handle login logic
      isLoading.value = true;
      try {
        var response = await ApiService.postApi(
          Apis.login,
          ctx,
          body: {
            "email": emailController.text,
            "password": passwordController.text
          },
        );

        if (response['success'] == true) {
          token = response['token'];
          secureUser(
              token: token, ctx: ctx, message: response['message'] ?? "");
        } else {
          isLoading.value = false;
          update();
          Get.showSnackbar(
            const GetSnackBar(
              message: 'Your are not registered',
              duration: Duration(seconds: 3),
            ),
          );
        }
      } catch (e) {
        isLoading.value = false;
        update();
        Get.showSnackbar(
          const GetSnackBar(
            message: 'There was an error.',
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  secureUser({
    required String token,
    required BuildContext ctx,
    required String message,
  }) async {
    try {
      var response = await ApiService.getApi(
        Apis.security,
        ctx,
        headers: {'token': token},
      );

      if (response['status'] == "success") {
        String id = response['decoded']['userId'];
        AppVariables.box.write(StorageKeys.aId, id);
        AppVariables.box.write(StorageKeys.isLoggedIn, true);

        var parentsResponse = await ApiService.getApi(
          Apis.getById(id: id),
          ctx,
        );

        if (parentsResponse != null) {
          AppVariables.box
              .write(StorageKeys.aName, parentsResponse['user']['name']);
          AppVariables.box.write(
              StorageKeys.aImage,
              (parentsResponse['user']['profileImage'] == null)
                  ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"
                  : "${Apis.serverAddress}/${parentsResponse['user']['profileImage']}");

          AppVariables.box
              .write(StorageKeys.aEmail, parentsResponse['user']['email']);
          AppVariables.box
              .write(StorageKeys.aPhone, parentsResponse['user']['phone']);
          AppVariables.box
              .write(StorageKeys.aAddress, parentsResponse['user']['address']);
          AppVariables.box
              .write(StorageKeys.aRole, parentsResponse['user']['role']);

          String? fcmToken = await FirebaseMessaging.instance.getToken();

          AppVariables.box.write(StorageKeys.aToken, fcmToken);

          await ApiService.postApi(Apis.saveToken, ctx,
              body: {"token": fcmToken, "sender_id": id});

          isLoading.value = false;
          update();
          emailController.clear();
          passwordController.clear();
          if (parentsResponse['user']['access'] == false) {
            AppVariables.box.write(StorageKeys.access, false);
            Get.offAllNamed(Routes.accessPage);
          } else {
            AppVariables.box.write(StorageKeys.access, true);
            Get.offAllNamed('/navigation');
          }
        }
      }
      isLoading.value = false;
      update();
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          message: e.toString(),
          duration: const Duration(seconds: 3),
        ),
      );
      isLoading.value = false;
      update();
    }
  }

  void navigateToSignUp() {
    // Navigate to Sign Up Screen
    Get.toNamed(Routes.signup);
  }
}
