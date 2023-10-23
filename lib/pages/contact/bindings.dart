import 'package:get/instance_manager.dart';
import 'package:x_connect/pages/contact/controller.dart';

class ContactBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactController>(() => ContactController());
  }
}
