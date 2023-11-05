import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:x_connect/common/apis/chat.dart';
import 'package:x_connect/common/entities/base.dart';
import 'package:x_connect/common/routes/routes.dart';
import 'package:x_connect/common/store/user.dart';
import 'package:x_connect/pages/message/state.dart';

class MessageController extends GetxController {
  MessageController();
  final state = MessageState();

  goProfile() async {
    // var result = await Get.toNamed(AppRoutes.Profile, arguments: state.head_detail.value);
    // if (result == "finish") {
    //   getProfile();
    // }

    await Get.toNamed(AppRoutes.Profile, arguments: state.head_detail.value);
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
      // await ChatAPI.bind_fcmtoken(params: bindFcmTokenRequestEntity);
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
