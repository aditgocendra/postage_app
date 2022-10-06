import 'package:check_postage_app/app/core/utils/dialog_util.dart';
import 'package:check_postage_app/app/data/models/city_model.dart';
import 'package:check_postage_app/app/data/models/province_model.dart';
import 'package:check_postage_app/app/data/repositories/postage_repository.dart';
import 'package:check_postage_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final originProvince = '0'.obs;
  final originCity = '0'.obs;
  final destinationProvince = '0'.obs;
  final destinationCity = '0'.obs;

  // Courier Selected
  Map<String, dynamic>? courierSelected;

  // List Model Data
  List<ProvinceModel> listProvince = [];
  List<CityModel> listCity = [];

  // Text Editing Controller
  TextEditingController weightTec = TextEditingController();

  // Repository
  final repoCheckPostage = Get.find<PostageRepository>();

  // Set Province Data
  Future setProvinceData() async {
    final result = await repoCheckPostage.getProvinces();
    if (result.isLeft) {
      Get.defaultDialog(title: "Error", middleText: result.left.message ?? '');
      return;
    }

    listProvince = result.right;
    update();
  }

  // Set City Data
  Future<List<CityModel>> setCity(String provinceId) async {
    final result = await repoCheckPostage.getCity(provinceId);
    if (result.isLeft) {
      Get.defaultDialog(title: "Error", middleText: result.left.message ?? '');
      return listCity;
    }

    return result.right;
  }

  // Check Postage
  Future checkPostage() async {
    String valid = validationField();
    if (valid.isNotEmpty) {
      DialogUtility.snackbarDialog('Form Error', valid);
      return;
    }

    Map<String, dynamic> params = {
      'origin': originCity.value,
      'destination': destinationCity.value,
      'weight': weightTec.text.trim(),
      'courier': courierSelected,
    };

    Get.toNamed(Routes.resultPostage, arguments: params);
  }

  // Validation Field
  String validationField() {
    if (originProvince.value == "0") {
      return "Provinsi asal belum dipilih";
    }
    if (originCity.value == "0") {
      return "Kota asal belum dipilih";
    }
    if (destinationProvince.value == "0") {
      return "Provinsi tujuan belum dipilih";
    }
    if (destinationCity.value == "0") {
      return "Kota tujuan belum dipilih";
    }
    if (courierSelected == null) {
      return "Kurir belum dipilih";
    }
    if (weightTec.text.isEmpty) {
      return "Berat barang masih kosong";
    }

    if (int.parse(weightTec.text) >= 30000) {
      return 'Batas berat barang 30.000 Gram';
    }

    return "";
  }

  @override
  void onInit() async {
    await setProvinceData();
    super.onInit();
  }
}
