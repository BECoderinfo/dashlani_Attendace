class NotificationModal {
  final String id;
  final String? resiveModel;
  final String title;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final dynamic resiveId;

  NotificationModal({
    required this.id,
    required this.resiveModel,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.resiveId,
  });

  factory NotificationModal.fromJson(Map<String, dynamic> json) =>
      NotificationModal(
        id: json["_id"],
        resiveModel: json["resiveModel"],
        title: json["title"],
        description: json["description"]!,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        resiveId: json["resiveId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "resiveModel": resiveModel,
        "title": title,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "resiveId": resiveId,
      };
}
