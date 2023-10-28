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
