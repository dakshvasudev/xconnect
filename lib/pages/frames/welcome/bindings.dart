import 'package:get/instance_manager.dart';
import 'package:x_connect/pages/frames/welcome/controller.dart';

class WelcomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelcomeController>(() => WelcomeController());
  }
}
