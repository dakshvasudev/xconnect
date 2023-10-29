import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:x_connect/common/apis/apis.dart';
import 'package:x_connect/common/entities/contact.dart';
import 'package:x_connect/common/entities/msg.dart';
import 'package:x_connect/common/store/user.dart';
import 'package:x_connect/pages/contact/state.dart';

class ContactController extends GetxController {
  ContactController();
  final title = "Xconnect";
  final state = ContactState();
  final token = UserStore.to.profile.token;
  final db = FirebaseFirestore.instance;
  @override
  void onReady() {
    super.onReady();
    asyncLoadAllData();
  }

  void goChat(ContactItem contactItem) async {
    var from_messages = await db
        .collection("message")
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        )
        .where("from_token", isEqualTo: token)
        .where("to_token", isEqualTo: contactItem.token)
        .get();
    var to_messages = await db
        .collection("message")
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, options) => msg.toFirestore(),
        )
        .where("from_token", isEqualTo: contactItem.token)
        .where("to_token", isEqualTo: token)
        .get();
    if (from_messages.docs.isEmpty && to_messages.docs.isEmpty) {
      if (kDebugMode) {
        print("----from_messages--to_messages--empty--");
      }
      var profile = UserStore.to.profile;
      var msgdata = Msg(
        from_token: profile.token,
        to_token: contactItem.token,
        from_name: profile.name,
        to_name: contactItem.name,
        from_avatar: profile.avatar,
        to_avatar: contactItem.avatar,
        from_online: profile.online,
        to_online: contactItem.online,
        last_msg: "",
        last_time: Timestamp.now(),
        msg_num: 0,
      );
      var doc_id = await db
          .collection("message")
          .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore(),
          )
          .add(msgdata);
      // Get.offAndToNamed("/chat", parameters: {
      //   "doc_id": doc_id.id,
      //   "to_token": contactItem.token ?? "",
      //   "to_name": contactItem.name ?? "",
      //   "to_avatar": contactItem.avatar ?? "",
      //   "to_online": contactItem.online.toString()
      // });
      if (kDebugMode) {
        print('----------creating new document and adding user info done------');
      }
    } else {
      if (kDebugMode) {
        print('----------users are older-----');
      }
    }
  }

  asyncLoadAllData() async {
    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    state.contactList.clear();
    var result = await ContactAPI.post_contact();
    if (kDebugMode) {
      print(result.code == 0);
    }
    if (result.code == 0) {
      state.contactList.addAll(result.data!);
    }
    EasyLoading.dismiss();
  }
}
