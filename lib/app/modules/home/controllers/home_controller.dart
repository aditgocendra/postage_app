import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../core/utils/dialog_util.dart';
import '../../../data/models/city_model.dart';
import '../../../data/models/province_model.dart';
import '../../../data/repositories/postage_repository.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  late BannerAd bannerAd;
  final isLoadingAds = true.obs;

  var unitBannerAds = dotenv.env['UNIT_BANNER_ADS'];
  var unitTestBannerAds = dotenv.env['UNIT_TEST_BANNER_ADS'];

  // OBS
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
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: result.left.message ?? '',
      );
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

  // Refresh View
  void refreshData() {
    Get.offAndToNamed(Routes.home);
  }

  @override
  void onInit() async {
    await setProvinceData();

    bannerAd = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: unitBannerAds!,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          // print('$ad loaded admob : ${ad.responseInfo}');
          bannerAd = ad as BannerAd;
          isLoadingAds.toggle();
        },
        onAdFailedToLoad: (ad, error) {
          isLoadingAds.toggle();

          // ad.dispose();
        },
      ),
      request: const AdRequest(),
    );

    bannerAd.load();

    super.onInit();
  }
}
