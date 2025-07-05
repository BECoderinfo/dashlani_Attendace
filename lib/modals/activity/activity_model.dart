class ActivityModel {
  final String id;
  final String userId;
  final String activityType;
  final String? title;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  ActivityModel({
    required this.id,
    required this.userId,
    required this.activityType,
    this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
        id: json["_id"],
        userId: json["userId"],
        activityType: json["activityType"],
        title: json["title"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "activityType": activityType,
        "title": title,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
