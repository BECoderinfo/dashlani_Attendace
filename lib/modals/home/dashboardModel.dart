class dashModal {
  String? checkInTime;
  String? checkOutTime;
  int? paidLeaves;
  int? unpaidLeaves;
  int? totalAttendances;

  dashModal(
      {this.checkInTime,
      this.checkOutTime,
      this.paidLeaves,
      this.unpaidLeaves,
      this.totalAttendances});

  dashModal.fromJson(Map<String, dynamic> json) {
    checkInTime = json['checkInTime'];
    checkOutTime = json['checkOutTime'];
    paidLeaves = json['PaidLeaves'];
    unpaidLeaves = json['UnpaidLeaves'];
    totalAttendances = json['totalAttendances'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['checkInTime'] = checkInTime;
    data['checkOutTime'] = checkOutTime;
    data['PaidLeaves'] = paidLeaves;
    data['UnpaidLeaves'] = unpaidLeaves;
    data['totalAttendances'] = totalAttendances;
    return data;
  }
}
