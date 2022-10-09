import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/utils/color_util.dart';
import '../../../core/utils/format_util.dart';
import '../../../data/models/courier_service_model.dart';
import '../controllers/result_postage_controller.dart';

class ResultPostageView extends GetView<ResultPostageController> {
  const ResultPostageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Obx(
          () {
            if (controller.isLoading.isTrue) {
              return LoadingAnimationWidget.staggeredDotsWave(
                color: primaryColor,
                size: 50,
              );
            }

            return Text(
              controller.courierName.value,
              style: const TextStyle(
                fontSize: 16,
                color: blackColor,
              ),
            );
          },
        ),
        centerTitle: true,
        backgroundColor: whiteColor,
      ),
      body: GetBuilder(
        init: controller,
        builder: (_) {
          if (controller.isLoading.isTrue) {
            return const LoadingCustom();
          }
          return ListView.builder(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(12),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.listCourierServicePostage.length,
            itemBuilder: (context, index) {
              return CardCourierService(
                serviceCourier: controller.listCourierServicePostage[index],
              );
            },
          );
        },
      ),
    );
  }
}

class LoadingCustom extends StatelessWidget {
  const LoadingCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(64.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'assets/images/art/loading_art.png',
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Tunggu bentar yaa',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class CardCourierService extends StatelessWidget {
  final CourierServiceModel serviceCourier;
  const CardCourierService({
    super.key,
    required this.serviceCourier,
  });

  @override
  Widget build(BuildContext context) {
    final cost = serviceCourier.cost![0];
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ListTile(
            title: Text(
              serviceCourier.service!,
              style: const TextStyle(fontSize: 12),
            ),
            subtitle: Text(
              "Estimasi : ${cost.etd}",
              style: const TextStyle(fontSize: 10),
            ),
            trailing: Text(
              FormatUtility.currencyRupiah(cost.value!),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
