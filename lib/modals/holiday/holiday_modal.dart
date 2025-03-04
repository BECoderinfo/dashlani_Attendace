class Holiday {
  final String id;
  final String title;
  final String type;
  final DateTime startDate;
  final int v;
  final DateTime? endDate;

  Holiday({
    required this.id,
    required this.title,
    required this.type,
    required this.startDate,
    required this.v,
    this.endDate,
  });

  factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
        id: json["_id"],
        title: json["title"],
        type: json["type"],
        startDate: DateTime.parse(json["startDate"]),
        v: json["__v"],
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "type": type,
        "startDate": startDate.toIso8601String(),
        "__v": v,
        "endDate": endDate?.toIso8601String(),
      };
}
