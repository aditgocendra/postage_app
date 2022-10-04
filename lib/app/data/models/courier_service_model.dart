import 'package:check_postage_app/app/data/models/cost_model.dart';

class CourierServiceModel {
  String? service;
  String? description;
  List<CostModel>? cost;

  CourierServiceModel({this.service, this.description, this.cost});

  CourierServiceModel.fromJson(Map<String, dynamic> json) {
    service = json['service'];
    description = json['description'];
    if (json['cost'] != null) {
      cost = <CostModel>[];
      json['cost'].forEach((v) {
        cost?.add(CostModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['service'] = service;
    data['description'] = description;
    if (cost != null) {
      data['cost'] = cost?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<CourierServiceModel> fromJsonList(List? data) {
    if (data == null || data.isEmpty) return [];
    return data.map((json) => CourierServiceModel.fromJson(json)).toList();
  }
}
