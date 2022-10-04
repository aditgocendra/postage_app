import 'package:get/get.dart';

import '../controllers/result_postage_controller.dart';

class ResultPostageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResultPostageController>(
      () => ResultPostageController(),
    );
  }
}
