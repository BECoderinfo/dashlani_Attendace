import 'package:flutter/cupertino.dart';

import '../../utils/import.dart';

class CreateLeave extends StatelessWidget {
  const CreateLeave({super.key});

  @override
  Widget build(BuildContext context) {
    CreateLeaveController controller =
        Get.put(CreateLeaveController(ctx: context));
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Gap(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: const Icon(CupertinoIcons.back),
                  onTap: () {
                    Get.back();
                  },
                ),
                Obx(
                  () => controller.updateMode.value
                      ? const Text(
                          'Update Leave',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        )
                      : const Text(
                          'Apply Leaves',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                          ),
                        ),
                ),
                const Gap(10),
              ],
            ),
            const Gap(40),
            Form(
              key: controller.formKey,
              child: Column(
                children: [
                  const Gap(16),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      label: Text(
                        'Leave Type',
                        style: TextStyle(color: AppColors.iconColor),
                      ),
                    ),
                    value: controller.leaveType.value,
                    icon: const Icon(CupertinoIcons.chevron_down),
                    items: const [
                      DropdownMenuItem(
                        value: 'casual',
                        child: Text('Casual Leave'),
                      ),
                      DropdownMenuItem(
                        value: 'sick',
                        child: Text('Medical Leave'),
                      ),
                      DropdownMenuItem(
                        value: 'annual',
                        child: Text('Annual Leave'),
                      )
                    ],
                    onChanged: (value) {
                      controller.leaveType.value = value!;
                    },
                  ),
                  const Gap(16),
                  TextFormField(
                    controller: controller.contactController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text(
                        'Contact Number',
                        style: TextStyle(color: AppColors.iconColor),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter contact number';
                      }
                      if (value.length < 10) {
                        return 'Please enter valid contact number';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  TextFormField(
                    readOnly: true,
                    controller: controller.startDateController,
                    decoration: InputDecoration(
                      label: const Text(
                        'Start Date',
                        style: TextStyle(color: AppColors.iconColor),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          DateTime? date = await showDatePicker(
                            firstDate: DateTime(DateTime.now().year),
                            lastDate: DateTime(DateTime.now().year + 2),
                            initialDate: DateTime.now(),
                            context: context,
                          );

                          if (date != null) {
                            controller.startDate = date;

                            controller.startDateController.text =
                                DateFormat('MMM d, yyyy').format(date);
                          }
                        },
                        child: const Icon(CupertinoIcons.calendar),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please select start date';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  TextFormField(
                    readOnly: true,
                    controller: controller.endDateController,
                    decoration: InputDecoration(
                      label: const Text(
                        'End Date',
                        style: TextStyle(color: AppColors.iconColor),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          DateTime? date = await showDatePicker(
                            firstDate: DateTime(DateTime.now().year),
                            lastDate: DateTime(DateTime.now().year + 2),
                            initialDate: DateTime.now(),
                            context: context,
                          );

                          if (date != null) {
                            controller.endDate = date;

                            controller.endDateController.text =
                                DateFormat('MMM d, yyyy').format(date);
                          }
                        },
                        child: const Icon(CupertinoIcons.calendar),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please select end date';
                      }
                      if (controller.startDate == null) {
                        return 'Please select start date';
                      }
                      if (controller.startDate!.isAfter(controller.endDate!)) {
                        return 'End date should be greater than start date';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  TextFormField(
                    controller: controller.leaveReasonController,
                    decoration: const InputDecoration(
                      label: Text(
                        'Reason for Leave',
                        style: TextStyle(color: AppColors.iconColor),
                      ),
                    ),
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(
        () => GestureDetector(
          onTap: controller.isSaving.value
              ? null
              : () {
                  controller.updateMode.value
                      ? controller.edit()
                      : controller.submit();
                },
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.iconColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: controller.isSaving.value
                ? const CircularProgressIndicator(
                    color: AppColors.whiteColor,
                  )
                : controller.updateMode.value
                    ? const Text(
                        'Update Leave',
                        style: TextStyle(
                            color: AppColors.whiteColor, fontSize: 18),
                      )
                    : const Text(
                        'Apply Leave',
                        style: TextStyle(
                            color: AppColors.whiteColor, fontSize: 18),
                      ),
          ),
        ),
      ),
    );
  }
}
