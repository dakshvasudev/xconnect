import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:x_connect/common/entities/msgcontent.dart';
import 'package:x_connect/common/routes/names.dart';
import 'package:x_connect/common/store/user.dart';
import 'package:x_connect/common/widgets/toast.dart';
import 'package:x_connect/pages/message/chat/state.dart';

class ChatController extends GetxController {
  ChatController();
  final TextEditingController myinputController = TextEditingController();
  final token = UserStore.to.profile.token;
  final state = ChatState();
  final db = FirebaseFirestore.instance;

  late String doc_id;
  goMore() {
    state.more_status.value = state.more_status.value ? false : true;
  }

  callAudio() async {
    state.more_status.value = false;
    Get.toNamed(AppRoutes.VoiceCall, parameters: {
      "doc_id": doc_id,
      "to_token": state.to_token.value,
      "to_name": state.to_name.value,
      "to_avatar": state.to_avatar.value,
      "call_role": "anchor"
    });
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

  sendMessage() async {
    print("---------------chat-----------------");
    String sendcontent = myinputController.text;
    if (sendcontent.isEmpty) {
      toastInfo(msg: "content not empty");
      return;
    }
    print("---------------chat--$sendcontent-----------------");
    final content = Msgcontent(
      token: token,
      content: sendcontent,
      type: "text",
      addtime: Timestamp.now(),
    );

    await db
        .collection("message")
        .doc(doc_id)
        .collection("msglist")
        .withConverter(
          fromFirestore: Msgcontent.fromFirestore,
          toFirestore: (Msgcontent msgcontent, options) => msgcontent.toFirestore(),
        )
        .add(content)
        .then((DocumentReference doc) {
      print('DocumentSnapshot added with ID: ${doc.id}');
      myinputController.clear();
    });
    // var message_res = await db
    //     .collection("message")
    //     .doc(doc_id)
    //     .withConverter(
    //       fromFirestore: Msg.fromFirestore,
    //       toFirestore: (Msg msg, options) => msg.toFirestore(),
    //     )
    //     .get();
    // if (message_res.data() != null) {
    //   var item = message_res.data()!;
    //   int to_msg_num = item.to_msg_num == null ? 0 : item.to_msg_num!;
    //   int from_msg_num = item.from_msg_num == null ? 0 : item.from_msg_num!;
    //   if (item.from_token == token) {
    //     from_msg_num = from_msg_num + 1;
    //   } else {
    //     to_msg_num = to_msg_num + 1;
    //   }
    //   await db.collection("message").doc(doc_id).update({
    //     "to_msg_num": to_msg_num,
    //     "from_msg_num": from_msg_num,
    //     "last_msg": sendcontent,
    //     "last_time": Timestamp.now()
    //   });
    // }
    // sendNotifications("text");
  }
}
