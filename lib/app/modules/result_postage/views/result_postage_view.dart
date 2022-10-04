import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
        title: const Text(
          'Pos Indonesia',
          style: TextStyle(
            fontSize: 14,
            color: blackColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: whiteColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.listCourierServicePostage.length,
          itemBuilder: (context, index) {
            final serviceCourier = controller.listCourierServicePostage[index];
            return CardCourierService(serviceCourier: serviceCourier);
          },
        ),
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
              "${cost.etd}",
              style: const TextStyle(fontSize: 10),
            ),
            trailing: Text(
              FormatUtility.currencyRupiah(cost.value!),
              style: const TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
