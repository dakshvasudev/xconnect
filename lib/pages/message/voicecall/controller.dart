import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:x_connect/common/apis/chat.dart';
import 'package:x_connect/common/entities/chat.dart';
import 'package:x_connect/common/store/user.dart';
import 'package:x_connect/common/values/server.dart';
import 'package:x_connect/pages/message/voicecall/index.dart';

class VoiceCallController extends GetxController {
  VoiceCallController();

  final state = VoiceCallState();
  final player = AudioPlayer();
  String appId = APPID;
  String title = "Voice Call";
  final db = FirebaseFirestore.instance;
  final profile_token = UserStore.to.profile.token;
  late final RtcEngine engine;
  ChannelProfileType channelProfileType = ChannelProfileType.channelProfileCommunication;

  @override
  void onInit() {
    super.onInit();
    var data = Get.parameters;
    print(data);
    state.to_token.value = data["to_token"] ?? "";
    state.to_name.value = data["to_name"] ?? "";
    state.to_avatar.value = data["to_avatar"] ?? "";
    state.call_role.value = data["call_role"] ?? "";
    state.doc_id.value = data["doc_id"] ?? "";

    _initEngine();
  }

  Future<void> _initEngine() async {
    await player.setAsset("assets/Sound_Horizon.mp3");
    engine = createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(
      appId: appId,
    ));

    engine.registerEventHandler(RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        //logSink.log('[onError] err: $err, msg: $msg');
        print('[onError] err: $err, msg: $msg');
        // if(err!=ErrorCodeType.errOk){
        // Get.snackbar(
        //     "call error, confirm return！",
        //     "${msg}",
        //     duration: Duration(seconds: 60),
        //     isDismissible: false,
        //     mainButton: TextButton(
        //         onPressed: () {
        //           if (Get.isSnackbarOpen) {
        //             Get.closeAllSnackbars();
        //           }
        //           Get.offAndToNamed(AppRoutes.Message);
        //         },
        //         child: Container(
        //           width: 40.w,
        //           height: 40.w,
        //           padding: EdgeInsets.all(10.w),
        //           decoration: BoxDecoration(
        //             color: AppColors.primaryElementBg,
        //             borderRadius:
        //             BorderRadius.all(Radius.circular(30.w)),
        //           ),
        //           child: Image.asset("assets/icons/back.png"),
        //         )));
        // }
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        print('[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
        state.isJoined.value = true;
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        print('[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        state.isJoined.value = false;
      },
      onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) async {
        await player.pause();

        //   if (state.call_role == "anchor") {
        //     // callTime();
        //     // is_calltimer = true;
        //   }
      },
      onRtcStats: (RtcConnection connection, RtcStats stats) {
        print("time----- ");
        print(stats.duration);
      },
      // onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
      //   print("---onUserOffline----- ");
      // },
    ));
    //
    await engine.enableAudio();
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.setAudioProfile(
      profile: AudioProfileType.audioProfileDefault,
      scenario: AudioScenarioType.audioScenarioGameStreaming,
    );
    // // is anchor joinChannel
    await joinChannel();
    if (state.call_role == "anchor") {
      // await sendNotifications("voice");
      await player.play();
    }
  }

  Future<String> getToken() async {
    if (state.call_role == "anchor") {
      state.channelId.value = md5.convert(utf8.encode("${profile_token}_${state.to_token}")).toString();
    } else {
      state.channelId.value = md5.convert(utf8.encode("${state.to_token}_${profile_token}")).toString();
    }
    CallTokenRequestEntity callTokenRequestEntity = new CallTokenRequestEntity();
    callTokenRequestEntity.channel_name = state.channelId.value;
    print('-------channel id is ${state.channelId.value}');
    print('-------my access token is ${UserStore.to.token}');
    var res = await ChatAPI.call_token(params: callTokenRequestEntity);
    if (res.code == 0) {
      return res.data!;
    }
    return "";
  }

  joinChannel() async {
    await Permission.microphone.request();

    EasyLoading.show(indicator: CircularProgressIndicator(), maskType: EasyLoadingMaskType.clear, dismissOnTap: true);
    String token = await getToken();
    if (token.isEmpty) {
      EasyLoading.dismiss();
      Get.back();
      return;
    }

    await engine.joinChannel(
        token: token,
        channelId: state.channelId.value,
        uid: 0,
        options: ChannelMediaOptions(
          channelProfile: channelProfileType,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ));
    // if (state.call_role == "audience") {
    //   callTime();
    //   is_calltimer = true;
    // }
    EasyLoading.dismiss();
  }

  leaveChannel() async {
    EasyLoading.show(
        indicator: const CircularProgressIndicator(), maskType: EasyLoadingMaskType.clear, dismissOnTap: true);
    await player.pause();
    // await sendNotifications("cancel");
    //  await engine.leaveChannel();
    state.isJoined.value = false;
    // state.openMicrophone.value = true;
    // state.enableSpeakerphone.value = true;
    EasyLoading.dismiss();
    // if (Get.isSnackbarOpen) {
    //   Get.closeAllSnackbars();
    // }
    Get.back();
  }

  Future<void> _dispose() async {
    // if (is_calltimer) {
    //   calltimer.cancel();
    // }
    // if (state.call_role == "anchor") {
    //   addCallTime();
    // }
    await player.pause();
    await engine.leaveChannel();
    await engine.release();
    await player.stop();
  }

  @override
  void onClose() {
    super.onClose();
    _dispose();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }
}
