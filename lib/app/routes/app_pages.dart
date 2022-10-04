import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/result_postage/bindings/result_postage_binding.dart';
import '../modules/result_postage/views/result_postage_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.resultPostage,
      page: () => const ResultPostageView(),
      binding: ResultPostageBinding(),
    ),
  ];
}
