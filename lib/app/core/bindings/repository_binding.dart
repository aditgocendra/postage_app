import 'package:check_postage_app/app/data/repositories/postage_repository.dart';
import 'package:check_postage_app/app/data/repositories/postage_repository_impl.dart';
import 'package:get/get.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostageRepository>(
      () => PostageRepositoryImpl(),
    );
  }
}
