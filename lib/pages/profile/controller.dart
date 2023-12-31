import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:x_connect/common/apis/user.dart';
import 'package:x_connect/common/entities/user.dart';
import 'package:x_connect/common/store/user.dart';
import 'package:x_connect/common/widgets/toast.dart';
import 'package:x_connect/pages/profile/state.dart';

import '../../common/apis/apis.dart';

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

  goSave() async {
    if (state.profile_detail.value.name == null || state.profile_detail.value.name!.isEmpty) {
      toastInfo(msg: "name not empty!");
      return;
    }
    if (state.profile_detail.value.description == null || state.profile_detail.value.description!.isEmpty) {
      toastInfo(msg: "description not empty!");
      return;
    }
    if (state.profile_detail.value.avatar == null || state.profile_detail.value.avatar!.isEmpty) {
      toastInfo(msg: "avatar not empty!");
      return;
    }

    LoginRequestEntity updateProfileRequestEntity = new LoginRequestEntity();
    var userItem = state.profile_detail.value;
    updateProfileRequestEntity.avatar = userItem.avatar;
    updateProfileRequestEntity.name = userItem.name;
    updateProfileRequestEntity.description = userItem.description;
    updateProfileRequestEntity.online = userItem.online;

    var result = await UserAPI.UpdateProfile(params: updateProfileRequestEntity);
    print(result.code);
    print(result.msg);
    if (result.code == 0) {
      UserItem userItem = state.profile_detail.value;
      await UserStore.to.saveProfile(userItem);
      Get.back(result: "finish");
    }
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // _photo = File(pickedFile.path);
      uploadFile();
    } else {
      print('No image selected.');
    }
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      // _photo = File(pickedFile.path);
      uploadFile();
    } else {
      print('No image selected.');
    }
  }

  Future uploadFile() async {
    // if (_photo == null) return;
    // print(_photo);
    var result = await ChatAPI.upload_img(file: _photo);
    print(result.data);
    if (result.code == 0) {
      state.profile_detail.value.avatar = result.data;
      state.profile_detail.refresh();
    } else {
      toastInfo(msg: "image error");
    }
  }

  @override
  goLogout() async {
    await GoogleSignIn().signOut();
    await UserStore.to.onLogout();
  }
}
