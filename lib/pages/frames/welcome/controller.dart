import 'package:get/get.dart';
import 'package:x_connect/pages/frames/welcome/state.dart';

class WelcomeController extends GetxController {
  WelcomeController();
  final title = "Chatty .";
  final state = WelcomeState();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print("Welcome controller");
  }
}
