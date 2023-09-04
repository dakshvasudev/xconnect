import 'package:get/get.dart';
import 'package:x_connect/common/routes/routes.dart';
import 'package:x_connect/pages/frames/welcome/state.dart';

class WelcomeController extends GetxController {
  WelcomeController();
  final title = "Xconnect";
  final state = WelcomeState();

  @override
  void onReady() {
    super.onReady();
    Future.delayed(
       const Duration(seconds: 3), () => Get.offAllNamed(AppRoutes.Message));
  }
}
