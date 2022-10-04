import 'package:check_postage_app/app/data/remote/postage_remote_data.dart';
import 'package:check_postage_app/app/data/remote/postage_remote_data_impl.dart';
import 'package:get/get.dart';

class RemoteSourceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostageRemoteDataSource>(
      () => PostageRemoteDataImpl(),
    );
  }
}
