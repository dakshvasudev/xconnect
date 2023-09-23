import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:x_connect/common/store/user.dart';
import 'package:x_connect/pages/profile/state.dart';

class ProfileController extends GetxController {
  ProfileController();
  final title = "Xconnect";
  final state = ProfileState();

  goLogout() async {
    await GoogleSignIn().signOut();
    await UserStore.to.onLogout();
  }
}
