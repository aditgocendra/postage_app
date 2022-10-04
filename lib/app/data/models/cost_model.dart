class CostModel {
  int? value;
  String? etd;
  String? note;

  CostModel({this.value, this.etd, this.note});

  CostModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    etd = json['etd'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['value'] = value;
    data['etd'] = etd;
    data['note'] = note;
    return data;
  }
}
