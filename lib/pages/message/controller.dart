import 'package:get/get.dart';
import 'package:x_connect/common/routes/routes.dart';
import 'package:x_connect/pages/message/state.dart';

class MessageController extends GetxController {
  MessageController();
  final state = MessageState();

  goProfile() async {
    // var result = await Get.toNamed(AppRoutes.Profile, arguments: state.head_detail.value);
    // if (result == "finish") {
    //   getProfile();
    // }

    await Get.toNamed(AppRoutes.Profile);
  }
}
