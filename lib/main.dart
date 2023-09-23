import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:x_connect/common/routes/pages.dart';
import 'package:x_connect/common/style/theme.dart';
import 'package:x_connect/pages/global.dart';

Future<void> main() async {
  await Global.init();
  runApp(MyApp());
  // firebaseInit().whenComplete(() {
  //   FirebaseMassagingHandler.config();
  // });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xconnect',
      theme: AppTheme.light,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
