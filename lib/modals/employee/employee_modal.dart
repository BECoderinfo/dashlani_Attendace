class User {
  final String id;
  final String? empId;
  final String name;
  final String? phone;
  final String email;
  final String password;
  final String? role;
  final String? departments;
  final dynamic experience;
  final String? address;
  final String epmType;
  final int v;
  final String? profileImage;
  final bool access;
  final List<Document> documents;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.role,
    required this.departments,
    required this.experience,
    required this.address,
    required this.epmType,
    required this.v,
    required this.profileImage,
    required this.access,
    required this.documents,
    required this.updatedAt,
    this.empId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
        departments: json["departments"],
        experience: json["experience"],
        address: json["address"],
        epmType: json["epmType"],
        v: json["__v"],
        profileImage: json["profileImage"],
        access: json["access"],
        empId: json["empId"],
        documents: List<Document>.from(
            json["documents"].map((x) => Document.fromJson(x))),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
        "role": role,
        "departments": departments,
        "experience": experience,
        "address": address,
        "epmType": epmType,
        "__v": v,
        "profileImage": profileImage,
        "access": access,
        "empId": empId,
        "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Document {
  final String documentName;
  final String documentPath;
  final String id;

  Document({
    required this.documentName,
    required this.documentPath,
    required this.id,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        documentName: json["documentName"],
        documentPath: json["documentPath"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "documentName": documentName,
        "documentPath": documentPath,
        "_id": id,
      };
}
