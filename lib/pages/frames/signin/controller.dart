import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:x_connect/common/apis/apis.dart';
import 'package:x_connect/common/entities/entities.dart';
import 'package:x_connect/common/routes/routes.dart';
import 'package:x_connect/common/store/store.dart';
import 'package:x_connect/common/utils/http.dart';
import 'package:x_connect/common/widgets/widgets.dart';
import 'package:x_connect/pages/frames/signin/state.dart';

class SignInController extends GetxController {
  SignInController();
  final state = SignInState();

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['openid']);

  Future<void> handleSignIn(String type) async {
    //1: email, 2:google, 3: facebook , 4:apple ,5:phone
    try {
      if (type == 'phone number') {
        if (kDebugMode) {
          print('------you are logging in with phone number------');
        }
      } else if (type == 'google') {
        var user = await _googleSignIn.signIn();
        if (user != null) {
          String? displayName = user.displayName;
          String email = user.email;
          String id = user.id;
          String photoUrl = user.photoUrl ?? "assets/icons/google.png";
          LoginRequestEntity loginPanelListRequestEntity = LoginRequestEntity();
          loginPanelListRequestEntity.email = email;
          loginPanelListRequestEntity.name = displayName;
          loginPanelListRequestEntity.avatar = photoUrl;
          loginPanelListRequestEntity.open_id = id;
          loginPanelListRequestEntity.type = 2;
          asyncPostAllData();
        }
      } else {
        if (kDebugMode) {
          print('------login type not defined------');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('-----error with login $e-----');
      }
    }
  }

  // asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
  asyncPostAllData() async {
    // EasyLoading.show(indicator: const CircularProgressIndicator(),maskType: EasyLoadingMaskType.clear,dismissOnTap: true);
    // var result = await UserAPI.Login(params: loginRequestEntity);
    // print(result);
    // if(result.code==0){
    //   await UserStore.to.saveProfile(result.data!);
    //   EasyLoading.dismiss();
    print('-----------response-----------');
    var response = await HttpUtil().get('/api/index');
    print(response);
    Get.offAllNamed(AppRoutes.Message);
    // }else{
    //   EasyLoading.dismiss();
    //   toastInfo(msg: 'internet error');
  }
}
