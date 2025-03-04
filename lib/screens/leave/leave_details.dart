import 'package:attendance_app/modals/leave/leaveModal.dart';
import 'package:attendance_app/utils/import.dart';
import 'package:flutter/cupertino.dart';

class LeaveDetails extends StatelessWidget {
  const LeaveDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // LeaveDetailsController controller =
    // Get.put(LeaveDetailsController(ctx: context));
    LeaveModal leave = Get.arguments;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Gap(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: const Icon(
                    CupertinoIcons.back,
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
                const Text(
                  'Leaves Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
                (leave.status == "Pending")
                    ? IconButton(
                        onPressed: () {
                          Get.toNamed(Routes.applyLeave,
                              arguments: {'leave': leave});
                        },
                        icon: const Icon(Icons.edit),
                      )
                    : const Gap(30),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  _LeaveField(label: 'Employee', value: leave.userId.name),
                  _LeaveField(label: 'Leave Type', value: leave.type),
                  _LeaveField(
                    label: 'Date',
                    value:
                        "${DateFormat("MMM d, yyyy").format(leave.startDate)} - ${DateFormat("MMM d, yyyy").format(leave.endDate)}",
                  ),
                  _LeaveField(label: 'Reason', value: leave.reason),
                  _LeaveField(
                      label: 'Applied on',
                      value:
                          DateFormat("MMMM d, yyyy").format(leave.createdAt)),
                  _LeaveField(
                      label: 'Contact Number', value: '+91 ${leave.contactNo}'),
                  _LeaveField(label: 'Status', value: leave.status),
                  (leave.status == "Pending")
                      ? const Gap(0)
                      : _LeaveField(
                          label: 'Approved By', value: leave.approvedBy!.name),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LeaveField extends StatelessWidget {
  final String label;
  final String value;

  const _LeaveField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 2),
        const Divider(
          color: AppColors.bgColor,
        ),
      ],
    );
  }
}
