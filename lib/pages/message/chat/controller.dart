import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:x_connect/common/entities/msg.dart';
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
  ScrollController myscrollController = new ScrollController();
  var listener;
  bool isloadmore = true;

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
    var message_result = await db
        .collection("message")
        .doc(doc_id)
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        )
        .get();
    if (message_result.data() != null) {
      var item = message_result.data()!;
      int to_msg_num = item.to_msg_num == null ? 0 : item.to_msg_num!;
      int from_msg_num = item.from_msg_num == null ? 0 : item.from_msg_num!;
      if (item.from_token == token) {
        from_msg_num = from_msg_num + 1;
      } else {
        to_msg_num = to_msg_num + 1;
      }
      await db.collection("message").doc(doc_id).update({
        "to_msg_num": to_msg_num,
        "from_msg_num": from_msg_num,
        "last_msg": sendcontent,
        "last_time": Timestamp.now()
      });
    }
    // sendNotifications("text");
  }

  @override
  void onReady() {
    super.onReady();
    print("onReady------------");
    state.msgcontentList.clear();
    final messages = db
        .collection("message")
        .doc(doc_id)
        .collection("msglist")
        .withConverter(
          fromFirestore: Msgcontent.fromFirestore,
          toFirestore: (Msgcontent msg, options) => msg.toFirestore(),
        )
        .orderBy("addtime", descending: true)
        .limit(15);

    listener = messages.snapshots().listen((event) {
      print("current data: ${event.docs}");
      print("current data: ${event.metadata.hasPendingWrites}");
      List<Msgcontent> tempMsgList = <Msgcontent>[];
      for (var change in event.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            print("added----: ${change.doc.data()}");
            if (change.doc.data() != null) {
              tempMsgList.add(change.doc.data()!);
            }
            break;
          case DocumentChangeType.modified:
            print("Modified City: ${change.doc.data()}");
            break;
          case DocumentChangeType.removed:
            print("Removed City: ${change.doc.data()}");
            break;
        }
      }
      tempMsgList.reversed.forEach((element) {
        state.msgcontentList.value.insert(0, element);
      });
      state.msgcontentList.refresh();

      //     SchedulerBinding.instance.addPostFrameCallback((_) {
      //       if (myscrollController.hasClients) {
      //         myscrollController.animateTo(
      //           myscrollController.position.minScrollExtent,
      //           duration: const Duration(milliseconds: 300),
      //           curve: Curves.easeOut,
      //         );
      //       }
      //     });
      //   },
      //   onError: (error) => print("Listen failed: $error"),
      // );
      //
      // myscrollController.addListener(() {
      //   // print(myscrollController.offset);
      //   //  print(myscrollController.position.maxScrollExtent);
      //   if ((myscrollController.offset + 10) > myscrollController.position.maxScrollExtent) {
      //     if (isloadmore) {
      //       state.isloading.value = true;
      //       isloadmore = false;
      //       asyncLoadMoreData(state.msgcontentList.length);
      //     }
      //   }
    });
  }

  @override
  void onClose() {
    super.onClose();
    print("onClose-------");
    // clear_msg_num(doc_id);
    myinputController.dispose();
  }
}
