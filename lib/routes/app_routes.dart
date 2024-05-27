import 'package:evreka/bindings/auth_bindings.dart';
import 'package:evreka/bindings/map_bindings.dart';
import 'package:evreka/routes/page_names.dart';
import 'package:evreka/screens/login_screen.dart';
import 'package:evreka/screens/map_screen.dart';
import 'package:get/get.dart';

evrekaRoutes() => [
      GetPage(
        name: PageNames.shared.loginPage,
        page: () => const LoginScreen(),
        transition: Transition.leftToRightWithFade,
        binding: AuthBindings(),
      ),
      GetPage(
        name: PageNames.shared.mapPage,
        page: () => const MapScreen(),
        transition: Transition.leftToRightWithFade,
        binding: MapBindings(),
      ),
    ];
