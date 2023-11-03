import 'package:get/instance_manager.dart';
import 'package:x_connect/pages/message/voicecall/controller.dart';

class VoiceCallBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoiceCallController>(() => VoiceCallController());
  }
}
