import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:x_connect/common/services/storage.dart';
import 'package:x_connect/common/store/user.dart';
import 'package:x_connect/firebase_options.dart';

class Global {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // setSystemUi();
    // Loading();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await Get.putAsync<StorageService>(() => StorageService().init());
    // Get.put<ConfigStore>(ConfigStore());
    Get.put<UserStore>(UserStore());
  }

  // static void setSystemUi() {
  //   if (GetPlatform.isAndroid) {
  //     SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
  //       statusBarColor: Colors.transparent,
  //       statusBarBrightness: Brightness.light,
  //       statusBarIconBrightness: Brightness.dark,
  //       systemNavigationBarDividerColor: Colors.transparent,
  //       systemNavigationBarColor: Colors.white,
  //       systemNavigationBarIconBrightness: Brightness.dark,
  //     );
  //     SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  //   }
  // }
}
