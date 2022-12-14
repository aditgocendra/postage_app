import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../core/utils/color_util.dart';
import '../../../core/utils/style_util.dart';
import '../../../data/models/city_model.dart';
import '../../../data/models/province_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.refreshData();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          title: const Text(
            'Shipp',
            style: TextStyle(
              fontSize: 16,
              color: blackColor,
            ),
          ),
          centerTitle: true,
          backgroundColor: whiteColor,
        ),
        bottomNavigationBar: Container(
          color: whiteColor,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                controller.checkPostage();
              },
              style: StyleUtility().buttonStylePill(),
              child: const Text(
                "Periksa Biaya",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ),
        body: ContentBody(
          controller: controller,
        ),
      ),
    );
  }
}

class ContentBody extends StatelessWidget {
  const ContentBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Origin Province
        GetBuilder(
          init: controller,
          builder: (_) {
            return DropdownSearch<ProvinceModel>(
              itemAsString: (ProvinceModel prv) => prv.provinceAsString(),
              items: controller.listProvince,
              popupProps: PopupProps.menu(
                fit: FlexFit.loose,
                menuProps: const MenuProps(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                containerBuilder: (ctx, popupWidget) {
                  return StyleUtility().popupMenuDecoration(popupWidget);
                },
              ),
              dropdownDecoratorProps:
                  StyleUtility().dropdownDecorator("Provinsi Asal"),
              onChanged: (province) {
                controller.originProvince.value = province?.provinceId ?? "0";
              },
            );
          },
        ),
        const SizedBox(
          height: 16,
        ),
        // Origin City
        DropdownSearch<CityModel>(
          itemAsString: (CityModel city) => city.cityAsString(),
          asyncItems: (String filter) async {
            return await controller.setCity(controller.originProvince.value);
          },
          popupProps: PopupProps.menu(
            fit: FlexFit.loose,
            menuProps: const MenuProps(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            containerBuilder: (ctx, popupWidget) {
              return StyleUtility().popupMenuDecoration(popupWidget);
            },
          ),
          dropdownDecoratorProps:
              StyleUtility().dropdownDecorator("Kota / Kabupaten Asal"),
          onChanged: (city) {
            controller.originCity.value = city?.cityId ?? "0";
          },
        ),
        const SizedBox(
          height: 16,
        ),
        // Destination Province
        GetBuilder(
          init: controller,
          builder: (_) {
            return DropdownSearch<ProvinceModel>(
              itemAsString: (ProvinceModel prv) => prv.provinceAsString(),
              items: controller.listProvince,
              popupProps: PopupProps.menu(
                fit: FlexFit.loose,
                menuProps: const MenuProps(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                containerBuilder: (ctx, popupWidget) {
                  return StyleUtility().popupMenuDecoration(popupWidget);
                },
              ),
              dropdownDecoratorProps:
                  StyleUtility().dropdownDecorator("Provinsi Tujuan"),
              onChanged: (province) {
                controller.destinationProvince.value =
                    province?.provinceId ?? "0";
              },
            );
          },
        ),
        const SizedBox(
          height: 16,
        ),
        // Destination City
        DropdownSearch<CityModel>(
          itemAsString: (CityModel city) => city.cityAsString(),
          asyncItems: (String filter) async {
            return await controller.setCity(
              controller.destinationProvince.value,
            );
          },
          popupProps: PopupProps.menu(
            fit: FlexFit.loose,
            menuProps: const MenuProps(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            containerBuilder: (ctx, popupWidget) {
              return StyleUtility().popupMenuDecoration(popupWidget);
            },
          ),
          dropdownDecoratorProps:
              StyleUtility().dropdownDecorator("Kota / Kabupaten Tujuan"),
          onChanged: (city) {
            controller.destinationCity.value = city?.cityId ?? "0";
          },
        ),
        const SizedBox(
          height: 16,
        ),
        DropdownSearch<Map<String, dynamic>>(
          items: const [
            {
              "code": "jne",
              "name": "Jne",
            },
            {
              "code": "pos",
              "name": "Pos Indonesia",
            },
            {
              "code": "tiki",
              "name": "Tiki",
            },
          ],
          itemAsString: (item) => item['name'],
          popupProps: PopupProps.menu(
            fit: FlexFit.loose,
            menuProps: const MenuProps(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            containerBuilder: (ctx, popupWidget) {
              return StyleUtility().popupMenuDecoration(popupWidget);
            },
          ),
          dropdownDecoratorProps: StyleUtility().dropdownDecorator(
            "Pilih Kurir",
          ),
          onChanged: (value) => controller.courierSelected = value,
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          controller: controller.weightTec,
          cursorColor: primaryColor,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: StyleUtility().outlinedInputDecoration(
            'Berat Barang (Gram)',
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Obx(
          () {
            if (controller.isLoadingAds.value) {
              return Container();
            }

            return SizedBox(
              width: controller.bannerAd.size.width.toDouble(),
              height: controller.bannerAd.size.height.toDouble(),
              child: AdWidget(
                ad: controller.bannerAd,
              ),
            );
          },
        )
      ],
    );
  }
}
