import 'package:check_postage_app/app/core/bindings/remote_source_binding.dart';
import 'package:check_postage_app/app/core/bindings/repository_binding.dart';
import 'package:get/get.dart';

class InitializeBinding implements Bindings {
  @override
  void dependencies() {
    RemoteSourceBindings().dependencies();
    RepositoryBindings().dependencies();
  }
}
