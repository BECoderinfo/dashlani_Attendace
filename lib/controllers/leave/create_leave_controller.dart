import 'package:attendance_app/modals/leave/leaveModal.dart';
import 'package:flutter/cupertino.dart';

import '../../services/api_service.dart';
import '../../utils/import.dart';

class CreateLeaveController extends GetxController {
  final BuildContext ctx;

  CreateLeaveController({required this.ctx});

  LeaveModal? leave = Get.arguments != null ? Get.arguments['leave'] : null;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if (leave != null) {
      id = leave!.id;
      updateMode.value = true;
      leaveType.value = leave!.type;
      contactController.text = leave!.contactNo;
      startDateController.text =
          DateFormat('MMM d, yyyy').format(leave!.startDate);
      endDateController.text = DateFormat('MMM d, yyyy').format(leave!.endDate);
      startDate = leave!.startDate;
      endDate = leave!.endDate;
      leaveReasonController.text = leave!.reason;
    }
  }

  String? id;

  RxBool updateMode = false.obs;

  final formKey = GlobalKey<FormState>();

  RxString leaveType = 'casual'.obs;
  RxString numberOfDays = '0'.obs;
  final TextEditingController contactController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController leaveReasonController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  RxBool isSaving = false.obs;

  void edit() async {
    if (formKey.currentState!.validate()) {
      final daysDifference = endDate!.difference(startDate!).inDays +
          1; // +1 to include both start and end dates
      numberOfDays.value = daysDifference.toString();

      try {
        isSaving.value = true;
        var res = await ApiService.putApi(
          Apis.editLeaveRequest(id: id!),
          ctx,
          body: {
            'type': leaveType.value,
            'contactNo': contactController.text,
            'reason': (leaveReasonController.text.isEmpty)
                ? 'Non'
                : leaveReasonController.text,
            'startDate': startDateController.text,
            'endDate': endDateController.text,
            'numberOfDays': numberOfDays.value,
          },
        );

        if (res != null) {
          showModalBottomSheet(
            context: ctx,
            isDismissible: false,
            builder: (context) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const Gap(8),
                    Container(
                      height: 4,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.iconBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const Gap(30),
                    const CircleAvatar(
                      radius: 80,
                      backgroundColor: AppColors.iconBg,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.secondaryColor,
                        child: Icon(
                          CupertinoIcons.checkmark_alt_circle,
                          color: AppColors.whiteColor,
                          size: 40,
                        ),
                      ),
                    ),
                    const Gap(30),
                    const Text(
                      'Leave Updated\nSuccessfully!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(10),
                    const Text(
                      'Your leave has been\nupdated successfully.',
                      style: TextStyle(color: AppColors.black54Color),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 16, right: 16),
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                          Get.back();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Done',
                            style: TextStyle(
                                color: AppColors.whiteColor, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
          isSaving.value = false;
        }
      } on SocketException catch (_) {
        ShowToast.showFailedGfToast(
          msg: 'No internet connection. Please check your network.',
          ctx: ctx,
        );
      } on FormatException catch (_) {
        ShowToast.showFailedGfToast(
          msg: 'Invalid data format. Please try again.',
          ctx: ctx,
        );
      } catch (e) {
        ShowToast.showFailedGfToast(
          msg: 'An error occurred. Please try again later.',
          ctx: ctx,
        );
        log('Leave submission error: $e');
      } finally {
        isSaving.value = false;
        leaveReasonController.clear();
        contactController.clear();
        startDateController.clear();
        endDateController.clear();
      }
    }
  }

  void submit() async {
    if (formKey.currentState!.validate()) {
      final daysDifference = endDate!.difference(startDate!).inDays +
          1; // +1 to include both start and end dates
      numberOfDays.value = daysDifference.toString();

      try {
        isSaving.value = true;
        var res;

        res = await ApiService.postApi(
          Apis.leaveRequest,
          ctx,
          body: {
            'userId': AppVariables.box.read(StorageKeys.aId),
            'type': leaveType.value,
            'contactNo': contactController.text,
            'reason': (leaveReasonController.text.isEmpty)
                ? 'Non'
                : leaveReasonController.text,
            'startDate': startDateController.text,
            'endDate': endDateController.text,
            'numberOfDays': numberOfDays.value,
          },
        );

        if (res != null) {
          showModalBottomSheet(
            context: ctx,
            isDismissible: false,
            builder: (context) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const Gap(8),
                    Container(
                      height: 4,
                      width: 50,
                      decoration: BoxDecoration(
                        color: AppColors.iconBg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const Gap(30),
                    const CircleAvatar(
                      radius: 80,
                      backgroundColor: AppColors.iconBg,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.secondaryColor,
                        child: Icon(
                          CupertinoIcons.checkmark_alt_circle,
                          color: AppColors.whiteColor,
                          size: 40,
                        ),
                      ),
                    ),
                    const Gap(30),
                    const Text(
                      'Leave Applied\nSuccessfully!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(10),
                    const Text(
                      'Your leave has been\napplied successfully.',
                      style: TextStyle(color: AppColors.black54Color),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 16, right: 16),
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                          Get.back();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Done',
                            style: TextStyle(
                                color: AppColors.whiteColor, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
          isSaving.value = false;
        }
      } on SocketException catch (_) {
        ShowToast.showFailedGfToast(
          msg: 'No internet connection. Please check your network.',
          ctx: ctx,
        );
      } on FormatException catch (_) {
        ShowToast.showFailedGfToast(
          msg: 'Invalid data format. Please try again.',
          ctx: ctx,
        );
      } catch (e) {
        ShowToast.showFailedGfToast(
          msg: 'An error occurred. Please try again later.',
          ctx: ctx,
        );
        log('Leave submission error: $e');
      } finally {
        isSaving.value = false;
        leaveReasonController.clear();
        contactController.clear();
        startDateController.clear();
        endDateController.clear();
      }
    }
  }

  @override
  void onClose() {
    // leaveTypeController.dispose();
    leaveReasonController.dispose();
    contactController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.onClose();
  }
}
