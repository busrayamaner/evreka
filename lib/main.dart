import 'package:evreka/bindings/internet_connectivity_bindings.dart';
import 'package:evreka/firebase_options.dart';
import 'package:evreka/routes/app_routes.dart';
import 'package:evreka/routes/page_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'Evreka',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "Open Sans",
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: PageNames.shared.loginPage,
          getPages: evrekaRoutes(),
        );
      },
    );
  }
}
