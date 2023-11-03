import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:x_connect/common/values/values.dart';
import 'package:x_connect/pages/message/voicecall/controller.dart';

class VoiceCallPage extends GetView<VoiceCallController> {
  const VoiceCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary_bg,
      body: SafeArea(
        child: Obx(() {
          return Stack(children: [
            Positioned(
                top: 10,
                left: 30,
                right: 30,
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    child: Text(
                      controller.state.call_time.value,
                      style: const TextStyle(
                        color: AppColors.primaryElementText,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    margin: const EdgeInsets.only(top: 150),
                    padding: const EdgeInsets.all(0),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryElementText,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Image.network(
                      controller.state.to_avatar.value,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    child: Text(
                      controller.state.to_name.value,
                      style: const TextStyle(
                        color: AppColors.primaryElementText,
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  )
                ])),
            Positioned(
                bottom: 80,
                left: 30,
                right: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          // onTap: controller.state.isJoined.value
                          //     ? controller.switchMicrophone
                          //     : null,
                          child: Container(
                              width: 60,
                              height: 60,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: controller.state.openMicrophone.value
                                    ? AppColors.primaryElementText
                                    : AppColors.primaryText,
                                borderRadius: const BorderRadius.all(Radius.circular(30)),
                              ),
                              child: controller.state.openMicrophone.value
                                  ? Image.asset("assets/icons/b_microphone.png")
                                  : Image.asset("assets/icons/a_microphone.png")),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: const Text(
                            "Microphone",
                            style: TextStyle(
                              color: AppColors.primaryElementText,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(children: [
                      GestureDetector(
                        // onTap: controller.state.isJoined.value
                        //     ? controller.leaveChannel
                        //     : controller.joinChannel,
                        child: Container(
                          width: 60,
                          height: 60,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: controller.state.isJoined.value
                                ? AppColors.primaryElementBg
                                : AppColors.primaryElementStatus,
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                          ),
                          child: controller.state.isJoined.value
                              ? Image.asset("assets/icons/a_phone.png")
                              : Image.asset("assets/icons/a_telephone.png"),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(
                          controller.state.isJoined.value ? "Disconnect" : "Connected",
                          style: const TextStyle(
                            color: AppColors.primaryElementText,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ]),
                    Column(children: [
                      GestureDetector(
                        // onTap: controller.state.isJoined.value
                        //     ? controller.switchSpeakerphone
                        //     : null,
                        child: Container(
                          width: 60,
                          height: 60,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: controller.state.enableSpeakerphone.value
                                ? AppColors.primaryElementText
                                : AppColors.primaryText,
                            borderRadius: const BorderRadius.all(Radius.circular(30)),
                          ),
                          child: controller.state.enableSpeakerphone.value
                              ? Image.asset("assets/icons/bo_trumpet.png")
                              : Image.asset("assets/icons/a_trumpet.png"),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: const Text(
                          "Speakerphone",
                          style: TextStyle(
                            color: AppColors.primaryElementText,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      )
                    ]),
                  ],
                ))
          ]);
        }),
      ),
    );
  }
}
