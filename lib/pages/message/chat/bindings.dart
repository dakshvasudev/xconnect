import 'package:get/instance_manager.dart';
import 'package:x_connect/pages/message/chat/controller.dart';

class ChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
