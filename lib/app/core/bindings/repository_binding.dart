import 'package:check_postage_app/app/data/repositories/postage_repository.dart';
import 'package:check_postage_app/app/data/repositories/postage_repository_impl.dart';
import 'package:get/get.dart';

import '../../data/remote/postage_remote_data.dart';
import '../../data/remote/postage_remote_data_impl.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    PostageRemoteData postageRemoteData = PostageRemoteDataImpl();
    Get.lazyPut<PostageRepository>(
      () => PostageRepositoryImpl(postageRemoteData: postageRemoteData),
    );
  }
}
