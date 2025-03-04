class TermsModal {
  String? sId;
  String? rule;

  TermsModal({this.sId, this.rule});

  TermsModal.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    rule = json['Rule'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['Rule'] = rule;
    return data;
  }
}
