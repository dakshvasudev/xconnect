import 'package:get/get.dart';
import 'package:x_connect/pages/frames/welcome/state.dart';

class WelcomeController extends GetxController {
  WelcomeController();
  final title = "x connect";
  final state = WelcomeState();

  @override
  void onReady() {
    super.onReady();
    print("Welcome controller");
  }
}
