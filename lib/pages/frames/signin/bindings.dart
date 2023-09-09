import 'package:get/instance_manager.dart';
import 'package:x_connect/pages/frames/signin/controller.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
