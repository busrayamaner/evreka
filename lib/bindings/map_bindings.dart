import 'package:evreka/controllers/map_controller.dart';
import 'package:get/get.dart';

class MapBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MapController());
  }
}
