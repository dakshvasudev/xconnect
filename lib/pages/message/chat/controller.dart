import 'package:get/get.dart';
import 'package:x_connect/pages/message/chat/state.dart';

class ChatController extends GetxController {
  ChatController();
  final state = ChatState();
  late String doc_id;
  goMore() {
    state.more_status.value = state.more_status.value ? false : true;
  }

  @override
  void onInit() {
    super.onInit();
    print("onInit------------");
    var data = Get.parameters;
    print(data);
    doc_id = data["doc_id"]!;
    state.to_token.value = data["to_token"] ?? "";
    state.to_name.value = data["to_name"] ?? "";
    state.to_avatar.value = data["to_avatar"] ?? "";
    state.to_online.value = data["to_online"] ?? "1";
  }
}
