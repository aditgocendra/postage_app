import 'package:get/get.dart';

import '../../../core/utils/dialog_util.dart';
import '../../../data/models/courier_service_model.dart';
import '../../../data/repositories/postage_repository.dart';

class ResultPostageController extends GetxController {
  final isLoading = true.obs;

  // List Data
  List<CourierServiceModel> listCourierServicePostage = [];
  final courierName = ''.obs;

  // Repository
  final repoCheckPostage = Get.find<PostageRepository>();

  Future setPostageCourier(Map<String, dynamic> params) async {
    final result = await repoCheckPostage.getPostage(
      params['origin'],
      params['destination'],
      params['weight'],
      params['courier']['code'],
    );

    if (result.isLeft) {
      DialogUtility.dialogWarning('Kesalahan', result.left.message ?? '');
      return;
    }

    listCourierServicePostage = result.right;
    courierName.value = params['courier']['name'];
    isLoading.toggle();
    update();
  }

  @override
  void onInit() {
    final params = Get.arguments;

    setPostageCourier(params);

    super.onInit();
  }
}
