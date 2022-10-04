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
  final courier = ''.obs;

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
      Get.snackbar(
        'Snackbar',
        'message',
        snackPosition: SnackPosition.BOTTOM,
        messageText: Text(
          valid,
          style: const TextStyle(color: Colors.white),
        ),
        margin: EdgeInsets.zero,
        borderRadius: 0,
      );
      return;
    }

    final result = await repoCheckPostage.getPostage(
      originCity.value,
      destinationCity.value,
      weightTec.text.trim(),
      courier.value,
    );

    if (result.isLeft) {
      Get.defaultDialog(title: "Error", middleText: result.left.message ?? '');
      return;
    }
    Get.toNamed(Routes.resultPostage, arguments: result.right);
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
    if (courier.isEmpty) {
      return "Kurir belum dipilih";
    }
    if (weightTec.text.isEmpty) {
      return "Berat barang masih kosong";
    }

    return "";
  }

  @override
  void onInit() async {
    await setProvinceData();
    super.onInit();
  }
}
