import 'package:check_postage_app/app/core/utils/color_util.dart';
import 'package:check_postage_app/app/core/utils/style_util.dart';
import 'package:check_postage_app/app/data/models/city_model.dart';
import 'package:check_postage_app/app/data/models/province_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          decoration:
              StyleUtility().outlinedInputDecoration('Berat Barang (Gram)'),
        ),
      ],
    );
  }
}
