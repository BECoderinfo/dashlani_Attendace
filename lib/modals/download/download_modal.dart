class DownloadModal {
  String? sId;
  String? userId;
  String? documentName;
  String? document;
  String? createdAt;
  String? updatedAt;

  DownloadModal(
      {this.sId,
      this.userId,
      this.documentName,
      this.document,
      this.createdAt,
      this.updatedAt});

  DownloadModal.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    documentName = json['documentName'];
    document = json['document'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['documentName'] = documentName;
    data['document'] = document;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
