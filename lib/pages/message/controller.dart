import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:x_connect/common/apis/chat.dart';
import 'package:x_connect/common/entities/base.dart';
import 'package:x_connect/common/entities/msg.dart';
import 'package:x_connect/common/routes/routes.dart';
import 'package:x_connect/common/store/user.dart';
import 'package:x_connect/pages/message/state.dart';

import '../../common/entities/chatcall.dart';
import '../../common/entities/message.dart';

class MessageController extends GetxController {
  MessageController();
  final state = MessageState();
  final db = FirebaseFirestore.instance;
  final token = UserStore.to.profile.token;

  goProfile() async {
    // var result = await Get.toNamed(AppRoutes.Profile, arguments: state.head_detail.value);
    // if (result == "finish") {
    //   getProfile();
    // }

    await Get.toNamed(AppRoutes.Profile, arguments: state.head_detail.value);
  }

  goTabStatus() async {
    EasyLoading.show(
        indicator: const CircularProgressIndicator(), maskType: EasyLoadingMaskType.clear, dismissOnTap: true);
    state.tabStatus.value = !state.tabStatus.value;
    if (state.tabStatus.value) {
      asyncLoadMsgData();
    } else {
      asyncLoadCallData();
    }
    EasyLoading.dismiss();
  }

  asyncLoadCallData() async {
    state.callList.clear();
    var token = UserStore.to.profile.token;

    var from_chatcall = await db
        .collection("chatcall")
        .withConverter(
          fromFirestore: ChatCall.fromFirestore,
          toFirestore: (ChatCall msg, options) => msg.toFirestore(),
        )
        .where("from_token", isEqualTo: token)
        .limit(30)
        .get();
    var to_chatcall = await db
        .collection("chatcall")
        .withConverter(
          fromFirestore: ChatCall.fromFirestore,
          toFirestore: (ChatCall msg, options) => msg.toFirestore(),
        )
        .where("to_token", isEqualTo: token)
        .limit(30)
        .get();

    if (from_chatcall.docs.isNotEmpty) {
      await addCall(from_chatcall.docs);
    }
    if (to_chatcall.docs.isNotEmpty) {
      await addCall(to_chatcall.docs);
    }
    // sort
    state.callList.value.sort((a, b) {
      if (b.last_time == null) {
        return 0;
      }
      if (a.last_time == null) {
        return 0;
      }
      return b.last_time!.compareTo(a.last_time!);
    });
  }

  addCall(List<QueryDocumentSnapshot<ChatCall>> data) async {
    data.forEach((element) {
      var item = element.data();
      CallMessage message = new CallMessage();
      message.doc_id = element.id;
      message.last_time = item.last_time;
      message.call_time = item.call_time;
      message.type = item.type;
      if (item.from_token == token) {
        message.name = item.to_name;
        message.avatar = item.to_avatar;
        message.token = item.to_token;
      } else {
        message.name = item.from_name;
        message.avatar = item.from_avatar;
        message.token = item.from_token;
      }
      state.callList.add(message);
    });
  }

  asyncLoadMsgData() async {
    print("-----------state.msgList.value");
    print(state.msgList.value);
    var token = UserStore.to.profile.token;

    var from_messages = await db
        .collection("message")
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        )
        .where("from_token", isEqualTo: token)
        .get();
    print(from_messages.docs.length);

    var to_messages = await db
        .collection("message")
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        )
        .where("to_token", isEqualTo: token)
        .get();
    print("to_messages.docs.length------------");
    print(to_messages.docs.length);
    state.msgList.clear();

    if (from_messages.docs.isNotEmpty) {
      await addMessage(from_messages.docs);
    }
    if (to_messages.docs.isNotEmpty) {
      await addMessage(to_messages.docs);
    }
    // sort
    state.msgList.value.sort((a, b) {
      if (b.last_time == null) {
        return 0;
      }
      if (a.last_time == null) {
        return 0;
      }
      return b.last_time!.compareTo(a.last_time!);
    });
  }

  addMessage(List<QueryDocumentSnapshot<Msg>> data) async {
    data.forEach((element) {
      var item = element.data();
      Message message = new Message();
      message.doc_id = element.id;
      message.last_time = item.last_time;
      message.msg_num = item.msg_num;
      message.last_msg = item.last_msg;
      if (item.from_token == token) {
        message.name = item.to_name;
        message.avatar = item.to_avatar;
        message.token = item.to_token;
        message.online = item.to_online;
        message.msg_num = item.to_msg_num ?? 0;
      } else {
        message.name = item.from_name;
        message.avatar = item.from_avatar;
        message.token = item.from_token;
        message.online = item.from_online;
        message.msg_num = item.from_msg_num ?? 0;
      }
      state.msgList.add(message);
    });
  }

  getProfile() async {
    var Profile = await UserStore.to.profile;
    state.head_detail.value = Profile;
    state.head_detail.refresh();
  }

  @override
  void onInit() {
    super.onInit();
    getProfile();
    // _snapshots();
  }

  @override
  void onReady() async {
    super.onReady();
    firebaseMessagingSetup();
    // WidgetsBinding.instance.addObserver(this);
    // await CallVocieOrVideo();
  }

  firebaseMessagingSetup() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print(' my deice token is -- $fcmToken');
    if (fcmToken != null) {
      BindFcmTokenRequestEntity bindFcmTokenRequestEntity = BindFcmTokenRequestEntity();
      bindFcmTokenRequestEntity.fcmtoken = fcmToken;
      await ChatAPI.bind_fcmtoken(params: bindFcmTokenRequestEntity);
    }
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    //   print("\n notification on onMessageOpenedApp function \n");
    //   print(message.data);
    //   if (message.data != null && message.data["call_type"] != null) {
    //     //  ////1. voice 2. video 3. text, 4.cancel
    //     if (message.data["call_type"] == "text") {
    //       //  FirebaseMassagingHandler.flutterLocalNotificationsPlugin.cancelAll();
    //       var data = message.data;
    //       var to_token = data["token"];
    //       var to_name = data["name"];
    //       var to_avatar = data["avatar"];
    //       //  var doc_id = data["doc_id"];
    //       if (to_token != null && to_name != null && to_avatar != null) {
    //         var item = state.msgList.value.where((element) => element.token == to_token).first;
    //         print(item);
    //         if (item != null && Get.currentRoute.contains(AppRoutes.Message)) {
    //           Get.toNamed("/chat", parameters: {
    //             "doc_id": item.doc_id!,
    //             "to_token": item.token!,
    //             "to_name": item.name!,
    //             "to_avatar": item.avatar!,
    //             "to_online": item.online.toString()
    //           });
    //         }
    //       }
    //     }
    //   }
    // });
  }
}
