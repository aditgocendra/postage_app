class ProvinceModel {
  String? provinceId;
  String? province;

  ProvinceModel({this.provinceId, this.province});

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    provinceId = json['province_id'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['province_id'] = provinceId;
    data['province'] = province;
    return data;
  }

  static List<ProvinceModel> fromJsonList(List? data) {
    if (data == null || data.isEmpty) return [];
    return data.map((json) => ProvinceModel.fromJson(json)).toList();
  }

  String provinceAsString() => province!;
}
