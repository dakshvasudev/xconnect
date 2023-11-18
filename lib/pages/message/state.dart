import 'package:get/get.dart';
import 'package:x_connect/common/entities/entities.dart';

class MessageState {
  var head_detail = UserItem().obs;
  RxList<Message> msgList = <Message>[].obs;
  RxList<CallMessage> callList = <CallMessage>[].obs;
  RxBool tabStatus = true.obs;
}
