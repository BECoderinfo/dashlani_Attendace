class LeaveModal {
  final String id;
  final UserId userId;
  final String type;
  final String reason;
  final DateTime startDate;
  final DateTime endDate;
  final int numberOfDays;
  final String contactNo;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final ApprovedBy? approvedBy;

  LeaveModal({
    required this.id,
    required this.userId,
    required this.type,
    required this.reason,
    required this.startDate,
    required this.endDate,
    required this.numberOfDays,
    required this.contactNo,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.approvedBy,
  });

  factory LeaveModal.fromJson(Map<String, dynamic> json) => LeaveModal(
        id: json["_id"],
        userId: UserId.fromJson(json["userId"]),
        type: json["type"],
        reason: json["reason"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        numberOfDays: json["numberOfDays"],
        contactNo: json["contactNo"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        approvedBy: json["approvedBy"] == null
            ? null
            : ApprovedBy.fromJson(json["approvedBy"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId.toJson(),
        "type": type,
        "reason": reason,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "numberOfDays": numberOfDays,
        "contactNo": contactNo,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "approvedBy": approvedBy?.toJson(),
      };
}

class ApprovedBy {
  final String id;
  final String name;

  ApprovedBy({
    required this.id,
    required this.name,
  });

  factory ApprovedBy.fromJson(Map<String, dynamic> json) => ApprovedBy(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class UserId {
  final String id;
  final String name;
  final String? phone;
  final String? role;
  final String? profileImage;

  UserId({
    required this.id,
    required this.name,
    this.phone,
    this.role,
    this.profileImage,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        name: json["name"],
        phone: json["phone"],
        role: json["role"],
        profileImage: json["profileImage"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phone": phone,
        "role": role,
        "profileImage": profileImage,
      };
}
