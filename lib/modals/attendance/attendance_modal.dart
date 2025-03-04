class attendanceModal {
  int? monthlyWorkingDays;
  int? monthlypresentDays;
  int? monthlyAbsentDays;
  int? monthlyHours;
  String? hours;
  List<Attendance>? attendance;

  attendanceModal(
      {this.monthlyWorkingDays,
      this.monthlypresentDays,
      this.monthlyAbsentDays,
      this.monthlyHours,
      this.hours,
      this.attendance});

  attendanceModal.fromJson(Map<String, dynamic> json) {
    monthlyWorkingDays = json['monthlyWorkingDays'];
    monthlypresentDays = json['monthlypresentDays'];
    monthlyAbsentDays = json['monthlyAbsentDays'];
    monthlyHours = json['monthlyHours'];
    hours = json['hours'];
    if (json['attendance'] != null) {
      attendance = <Attendance>[];
      json['attendance'].forEach((v) {
        attendance!.add(new Attendance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['monthlyWorkingDays'] = monthlyWorkingDays;
    data['monthlypresentDays'] = monthlypresentDays;
    data['monthlyAbsentDays'] = monthlyAbsentDays;
    data['monthlyHours'] = monthlyHours;
    data['hours'] = hours;
    if (attendance != null) {
      data['attendance'] = attendance!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attendance {
  String? sId;
  String? userId;
  String? date;
  String? checkInTime;
  int? overtime;
  String? status;
  int? iV;
  String? checkOutTime;
  int? hoursWorked;

  Attendance(
      {this.sId,
      this.userId,
      this.date,
      this.checkInTime,
      this.overtime,
      this.status,
      this.iV,
      this.checkOutTime,
      this.hoursWorked});

  Attendance.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    date = json['date'];
    checkInTime = json['checkInTime'];
    overtime = json['overtime'];
    status = json['status'];
    iV = json['__v'];
    checkOutTime = json['checkOutTime'];
    hoursWorked = json['hoursWorked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['date'] = date;
    data['checkInTime'] = checkInTime;
    data['overtime'] = overtime;
    data['status'] = status;
    data['__v'] = iV;
    data['checkOutTime'] = checkOutTime;
    data['hoursWorked'] = hoursWorked;
    return data;
  }
}
