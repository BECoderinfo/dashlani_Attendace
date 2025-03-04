import 'package:attendance_app/controllers/leave/leave_controller.dart';
import 'package:attendance_app/modals/leave/leaveModal.dart';
import 'package:attendance_app/utils/import.dart';
import 'package:flutter/cupertino.dart';

class Leaves extends StatelessWidget {
  const Leaves({super.key});

  @override
  Widget build(BuildContext context) {
    LeaveController controller = Get.put(LeaveController(ctx: context));
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Gap(40),
            Row(
              children: [
                const Text(
                  'All Leaves',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  child: const Icon(CupertinoIcons.create),
                  onTap: () {
                    Get.toNamed(Routes.applyLeave);
                  },
                ),
                const Gap(10),
                const FilterBottomSheet(),
              ],
            ),
            const Gap(20),
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: GridItemTile(
                      title: 'Leave \nBalance',
                      value: controller.isLoading.value
                          ? '...'
                          : "${controller.totalLeaves.value}",
                      color: AppColors.iconColor,
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: GridItemTile(
                      title: 'Leave \nApproved',
                      value: controller.isLoading.value
                          ? '...'
                          : "${controller.totalApprovedLeaves.value}",
                      color: AppColors.green,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(16),
            Expanded(
                child: RefreshIndicator(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => Row(
                      children: [
                        Expanded(
                          child: GridItemTile(
                            title: 'Leave \nPending',
                            value: controller.isLoading.value
                                ? '...'
                                : "${controller.totalPendingLeaves.value}",
                            color: AppColors.teal,
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: GridItemTile(
                            title: 'Leave \nCancelled',
                            value: controller.isLoading.value
                                ? '...'
                                : "${controller.totalRejectedLeaves.value}",
                            color: AppColors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    decoration: BoxDecoration(
                        color: AppColors.bgColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Obx(
                      () => Row(
                        children: [
                          _TabButton(
                            text: 'Upcoming',
                            isActive: (controller.currentTab.value == 0)
                                ? true
                                : false,
                            onTap: () {
                              if (controller.currentTab.value != 0) {
                                controller.changeTab(index: 0);
                              }
                            },
                          ),
                          _TabButton(
                            text: 'Past',
                            isActive: (controller.currentTab.value == 1)
                                ? true
                                : false,
                            onTap: () {
                              if (controller.currentTab.value != 1) {
                                controller.changeTab(index: 1);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(20),
                  Obx(
                    () => Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        // Animation duration
                        transitionBuilder: (widget, animation) {
                          return SlideTransition(
                            // opacity: animation,
                            position: animation.drive(Tween(
                                begin: const Offset(1, 0), end: Offset.zero)),
                            child: widget,
                          );
                        },
                        child: (controller.isLoading.value)
                            ? const Center(child: CircularProgressIndicator())
                            : IndexedStack(
                                key: ValueKey<int>(controller.currentTab.value),
                                // Ensures animation happens correctly
                                index: controller.currentTab.value,
                                children: [
                                  // Upcoming Leaves
                                  (controller.upcomingLeaves.isEmpty)
                                      ? ListView(
                                          children: const [
                                            Center(
                                              child: Text('No Upcoming Leaves'),
                                            ),
                                          ],
                                        )
                                      : ListView.builder(
                                          padding: const EdgeInsets.all(0),
                                          shrinkWrap: true,
                                          itemCount:
                                              controller.upcomingLeaves.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final leave = controller
                                                .upcomingLeaves[index];
                                            return LeaveContainer(
                                              date:
                                                  "${DateFormat("MMM d, yyyy").format(leave.startDate)} - ${DateFormat("MMM d, yyyy").format(leave.endDate)}",
                                              applyDays:
                                                  "${leave.numberOfDays} days",
                                              leaveBalance: '0',
                                              approvedBy:
                                                  (leave.approvedBy == null)
                                                      ? ''
                                                      : leave.approvedBy!.name,
                                              status: (leave.status ==
                                                      'Pending')
                                                  ? LeaveStatus.pending
                                                  : (leave.status == 'Approved')
                                                      ? LeaveStatus.approved
                                                      : LeaveStatus.rejected,
                                              onTap: () {
                                                Get.toNamed(Routes.leaveDetails,
                                                    arguments: leave);
                                              },
                                            );
                                          },
                                        ),

                                  // Past Leaves
                                  (controller.pastLeaves.isEmpty)
                                      ? ListView(
                                          children: const [
                                            Center(
                                                child: Text('No Past Leaves')),
                                          ],
                                        )
                                      : ListView.builder(
                                          padding: const EdgeInsets.all(0),
                                          shrinkWrap: true,
                                          itemCount:
                                              controller.pastLeaves.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            LeaveModal leave =
                                                controller.pastLeaves[index];
                                            return LeaveContainer(
                                              date:
                                                  "${DateFormat("MMM d, yyyy").format(leave.startDate)} - ${DateFormat("MMM d, yyyy").format(leave.endDate)}",
                                              applyDays:
                                                  "${leave.numberOfDays} days",
                                              leaveBalance: '16',
                                              approvedBy: 'John Doe',
                                              status: (leave.status ==
                                                      'Pending')
                                                  ? LeaveStatus.pending
                                                  : (leave.status == 'Approved')
                                                      ? LeaveStatus.approved
                                                      : LeaveStatus.rejected,
                                              onTap: () {
                                                Get.toNamed(Routes.leaveDetails,
                                                    arguments: leave);
                                              },
                                            );
                                          },
                                        ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              onRefresh: () => controller.refreshScreen(),
            )),
          ],
        ),
      ),
    );
  }
}

class GridItemTile extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final VoidCallback? onTap;

  const GridItemTile({
    super.key,
    required this.title,
    required this.value,
    this.color = AppColors.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
            ),
            const Gap(10),
            Text(
              value,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback? onTap;

  const _TabButton(
      {required this.text, this.isActive = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isActive ? AppColors.iconColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class LeaveContainer extends StatelessWidget {
  final String date;
  final String applyDays;
  final String leaveBalance;
  final String approvedBy;
  final LeaveStatus status;
  final VoidCallback? onTap;

  const LeaveContainer({
    super.key,
    this.onTap,
    required this.date,
    required this.applyDays,
    required this.leaveBalance,
    required this.approvedBy,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Card(
          color: AppColors.whiteColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Date',
                          style: TextStyle(color: AppColors.black54Color),
                        ),
                        const Gap(10),
                        Text(
                          date,
                          style: const TextStyle(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: (status == LeaveStatus.pending)
                            ? AppColors.iconColor.withValues(alpha: 0.1)
                            : (status == LeaveStatus.approved)
                                ? AppColors.teal.withValues(alpha: 0.1)
                                : AppColors.red.withValues(alpha: 0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: (status == LeaveStatus.pending)
                          ? const Text(
                              'Pending',
                              style: TextStyle(color: AppColors.green),
                            )
                          : (status == LeaveStatus.approved)
                              ? const Text(
                                  'Approved',
                                  style: TextStyle(color: AppColors.teal),
                                )
                              : const Text(
                                  'Rejected',
                                  style: TextStyle(color: AppColors.red),
                                ),
                    ),
                  ],
                ),
                const Gap(8),
                const Divider(
                  color: AppColors.bgColor,
                ),
                const Gap(8),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Apply Days',
                          style: TextStyle(color: AppColors.black54Color),
                        ),
                        const Gap(10),
                        Text(
                          applyDays,
                          style: const TextStyle(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Leave Balance',
                          style: TextStyle(color: AppColors.black54Color),
                        ),
                        const Gap(10),
                        Text(
                          leaveBalance,
                          style: const TextStyle(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Approved By',
                          style: TextStyle(color: AppColors.black54Color),
                        ),
                        const Gap(10),
                        Text(
                          approvedBy,
                          style: const TextStyle(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum LeaveStatus {
  pending,
  approved,
  rejected,
}

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) => const FilterSheetContent(),
        );
      },
      child: const Icon(Icons.filter_alt_outlined, color: Colors.black),
    );
  }
}

class FilterSheetContent extends StatefulWidget {
  const FilterSheetContent({super.key});

  @override
  State<FilterSheetContent> createState() => _FilterSheetContentState();
}

class _FilterSheetContentState extends State<FilterSheetContent> {
  // Checkboxes state
  bool approved = true;
  bool unapproved = false;
  bool pending = false;
  bool sickLeave = true;
  bool plannedLeave = false;
  bool holiday = false;

  // Dropdown selection
  String? selectedMember = "Alexa Williams";
  final List<String> teamMembers = ["Alexa Williams", "John Doe", "Jane Smith"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 4,
                width: 40,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Filter",
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(CupertinoIcons.clear_circled),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Status",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
            ),
            const SizedBox(height: 8),
            CheckboxListTile(
              activeColor: AppColors.iconColor,
              contentPadding: EdgeInsets.zero,
              // dense: true,
              value: approved,
              onChanged: (value) => setState(() => approved = value!),
              title: const Text("Approved"),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              activeColor: AppColors.iconColor,
              contentPadding: EdgeInsets.zero,
              value: unapproved,
              onChanged: (value) => setState(() => unapproved = value!),
              title: const Text("Unapproved"),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              activeColor: AppColors.iconColor,
              contentPadding: EdgeInsets.zero,
              value: pending,
              onChanged: (value) => setState(() => pending = value!),
              title: const Text("Pending"),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const Divider(height: 32),
            const Text(
              "Leave Type",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
            ),
            const SizedBox(height: 8),
            CheckboxListTile(
              activeColor: AppColors.iconColor,
              contentPadding: EdgeInsets.zero,
              value: sickLeave,
              onChanged: (value) => setState(() => sickLeave = value!),
              title: const Text("Sick Leave"),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              activeColor: AppColors.iconColor,
              contentPadding: EdgeInsets.zero,
              value: plannedLeave,
              onChanged: (value) => setState(() => plannedLeave = value!),
              title: const Text("Planned Leave"),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              activeColor: AppColors.iconColor,
              contentPadding: EdgeInsets.zero,
              value: holiday,
              onChanged: (value) => setState(() => holiday = value!),
              title: const Text("Holiday"),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const Divider(height: 32),
            // const Text(
            //   "Team Member",
            //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(height: 8),
            // DropdownButtonFormField<String>(
            //   value: selectedMember,
            //   decoration: InputDecoration(
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //   ),
            //   items: teamMembers
            //       .map((member) => DropdownMenuItem(
            //             value: member,
            //             child: Text(member),
            //           ))
            //       .toList(),
            //   onChanged: (value) => setState(() => selectedMember = value),
            // ),
            // const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Reset logic
                      setState(() {
                        approved = false;
                        unapproved = false;
                        pending = false;
                        sickLeave = false;
                        plannedLeave = false;
                        holiday = false;
                        selectedMember = null;
                      });
                    },
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.bgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Reset",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.iconColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Apply",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
