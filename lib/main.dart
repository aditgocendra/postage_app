import 'package:check_postage_app/app/core/bindings/initial_binding.dart';
import 'package:check_postage_app/app/core/utils/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return GetMaterialApp(
      title: "Shipp",
      initialBinding: InitializeBinding(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      theme: ThemeData(
        primarySwatch: primaryColor,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.black87,
              ),
        ),
      ),
    );
  }
}
