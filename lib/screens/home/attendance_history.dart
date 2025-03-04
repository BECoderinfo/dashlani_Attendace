import '../../modals/attendance/attendance_modal.dart';
import '../../utils/import.dart';

class AttendanceHistory extends StatelessWidget {
  const AttendanceHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendanceHistoryController>(
      init: AttendanceHistoryController(ctx: context),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Attendance History'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Calendar Widget
                Obx(
                  () => TableCalendar(
                    focusedDay: controller.focusedDay,
                    firstDay: DateTime.utc(2000, 1, 1),
                    lastDay: DateTime.utc(2100, 12, 31),
                    calendarFormat:
                        controller.format.value ?? CalendarFormat.month,
                    onFormatChanged: (format) {
                      controller.format.value = format;
                      controller.update();
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      controller.onDateSelected(selectedDay, focusedDay);
                    },
                    selectedDayPredicate: (day) =>
                        isSameDay(controller.selectedDay, day),
                    calendarStyle: const CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: AppColors.buttonColor,
                        shape: BoxShape.circle,
                      ),
                      weekendTextStyle: TextStyle(color: AppColors.redColor),
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: true,
                      titleCentered: true,
                      formatButtonDecoration: BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      formatButtonTextStyle: const TextStyle(
                        color: AppColors.whiteColor,
                      ),
                      titleTextStyle: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const Divider(),
                // Attendance Details
                Obx(() {
                  if (controller.selectedAttendance.value == null) {
                    return const Center(
                      child: Text(
                        "No attendance data for the selected date",
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }
                  return AttendanceCard(
                    attendance: controller.selectedAttendance.value!,
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Card Widget for Attendance Details
class AttendanceCard extends StatelessWidget {
  final Attendance attendance;

  const AttendanceCard({required this.attendance, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date: ${attendance.date ?? 'N/A'}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  attendance.status != "Absent"
                      ? Icons.check_circle
                      : Icons.cancel,
                  color:
                      attendance.status != "Absent" ? Colors.green : Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Check-In:', style: TextStyle(fontSize: 14)),
                Text(attendance.checkInTime ?? 'N/A',
                    style: const TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Check-Out:', style: TextStyle(fontSize: 14)),
                Text(attendance.checkOutTime ?? 'N/A',
                    style: const TextStyle(fontSize: 14)),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Hours Worked:', style: TextStyle(fontSize: 14)),
                Text(
                  '${(attendance.hoursWorked ?? 0) ~/ 3600000} hrs ${(attendance.hoursWorked ?? 0) % 3600000 ~/ 60000} mins',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
