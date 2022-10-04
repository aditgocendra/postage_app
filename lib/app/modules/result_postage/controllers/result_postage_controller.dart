import 'package:get/get.dart';

import '../../../data/models/courier_service_model.dart';

class ResultPostageController extends GetxController {
  List<CourierServiceModel> listCourierServicePostage = [];

  @override
  void onInit() {
    final args = Get.arguments;
    listCourierServicePostage = args;
    super.onInit();
  }
}
