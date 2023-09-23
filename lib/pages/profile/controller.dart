import 'package:get/get.dart';
import 'package:x_connect/common/routes/routes.dart';
import 'package:x_connect/pages/profile/state.dart';

class ProfileController extends GetxController {
  ProfileController();
  final title = "Xconnect";
  final state = ProfileState();

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 3), () => Get.offAllNamed(AppRoutes.Message));
  }
}
