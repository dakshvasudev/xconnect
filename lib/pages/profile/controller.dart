import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:x_connect/common/store/user.dart';
import 'package:x_connect/pages/profile/state.dart';

class ProfileController extends GetxController {
  ProfileController();
  final title = "Xconnect";
  final state = ProfileState();
  TextEditingController? NameEditingController = TextEditingController();
  TextEditingController? DescriptionEditingController = TextEditingController();
  File? _photo;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    var userItem = Get.arguments;
    if (userItem != null) {
      state.profile_detail.value = userItem;
      if (state.profile_detail.value.name != null) {
        NameEditingController?.text = state.profile_detail.value.name!;
      }
      if (state.profile_detail.value.description != null) {
        DescriptionEditingController?.text = state.profile_detail.value.description!;
      }
    }
  }

  @override
  goLogout() async {
    await GoogleSignIn().signOut();
    await UserStore.to.onLogout();
  }
}
