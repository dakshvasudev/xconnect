import 'package:get/instance_manager.dart';
import 'package:x_connect/pages/message/controller.dart';

class MessageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageController>(() => MessageController());
  }
}
