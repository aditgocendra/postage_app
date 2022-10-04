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
        title: const Text('Ongkos Kirim'),
        centerTitle: true,
      ),
      body: ListView(
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
          TextField(
            controller: controller.weightTec,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: "Berat Barang",
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          DropdownSearch<Map<String, dynamic>>(
            items: const [
              {
                "code": "jne",
                "name": "JNE",
              },
              {
                "code": "pos",
                "name": "POS INDONESIA",
              },
              {
                "code": "tiki",
                "name": "TIKI",
              },
            ],
            itemAsString: (item) => item['name'],
            dropdownDecoratorProps: StyleUtility().dropdownDecorator(
              "Pilih Kurir",
            ),
            onChanged: (value) => controller.courier.value = value!['code'],
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
            onPressed: () {
              controller.checkPostage();
            },
            child: const Text("Cek Ongkos Kirim"),
          ),
          const SizedBox(
            height: 24,
          ),
          GetBuilder(
            init: controller,
            builder: (_) {
              if (controller.listCourierServicePostage.isEmpty) {
                return const Text("Halo mau kirim barang kemana nih");
              }
              return ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.listCourierServicePostage.length,
                itemBuilder: (context, index) {
                  final serviceCourier =
                      controller.listCourierServicePostage[index];
                  final cost = serviceCourier.cost![0];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Kurir Service : ${serviceCourier.service!}"),
                        Text("Desciption : ${serviceCourier.description!}"),
                        Text("Biaya : ${cost.value}"),
                        Text("Estimasi Tiba : ${cost.etd} Hari")
                      ],
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
