import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:x_connect/common/values/values.dart';
import 'package:x_connect/pages/message/chat/controller.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryBackground,
      title: Obx(() {
        return Container(
          padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
          child: Text(
            "${controller.state.to_name}",
            overflow: TextOverflow.clip,
            maxLines: 1,
            style: const TextStyle(
              fontFamily: 'Avenir',
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
              fontSize: 16,
            ),
          ),
        );
      }),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: Stack(alignment: Alignment.center, children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primarySecondaryBackground,
                borderRadius: const BorderRadius.all(Radius.circular(22)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: controller.state.to_avatar.value == null
                  ? const Image(
                      image: AssetImage('assets/images/account_header.png'),
                    )
                  : CachedNetworkImage(
                      imageUrl: controller.state.to_avatar.value,
                      height: 44,
                      width: 44,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(22)),
                          image: DecorationImage(image: imageProvider, fit: BoxFit.fill
                              // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                              ),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Image(
                        image: AssetImage('assets/images/account_header.png'),
                      ),
                    ),
            ),
            Positioned(
              bottom: 5,
              right: 0,
              height: 14,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: AppColors.primaryElementText),
                  color: controller.state.to_online.value == "1"
                      ? AppColors.primaryElementStatus
                      : AppColors.primarySecondaryElementText,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
              ),
            )
          ]),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(() => SafeArea(
              child: ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                // ChatList(),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    constraints: const BoxConstraints(maxHeight: 170, minHeight: 70),
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
                    color: AppColors.primaryBackground,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            width: 270,
                            constraints: const BoxConstraints(maxHeight: 170, minHeight: 30),
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBackground,
                              border: Border.all(color: AppColors.primarySecondaryElementText),
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Row(children: [
                              Container(
                                width: 220,
                                constraints: const BoxConstraints(maxHeight: 150, minHeight: 20),
                                child: TextField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  controller: controller.myinputController,
                                  autofocus: false,
                                  decoration: const InputDecoration(
                                    hintText: "Message...",
                                    isDense: true,
                                    contentPadding: EdgeInsets.only(left: 10, top: 0, bottom: 0),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    hintStyle: TextStyle(
                                      color: AppColors.primarySecondaryElementText,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  child: Image.asset("assets/icons/send.png"),
                                ),
                                onTap: () {
                                  controller.sendMessage();
                                },
                              )
                            ])),
                        GestureDetector(
                            child: Container(
                                height: 40,
                                width: 40,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryElement,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: const Offset(1, 1), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                                ),
                                child: controller.state.more_status.value
                                    ? Image.asset("assets/icons/by.png")
                                    : Image.asset("assets/icons/add.png")),
                            onTap: () {
                              controller.goMore();
                            }),
                      ],
                    ),
                  ),
                ),

                controller.state.more_status.value
                    ? Positioned(
                        right: 20,
                        bottom: 70,
                        height: 200,
                        width: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: const Offset(1, 1), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                                  ),
                                  child: Image.asset("assets/icons/file.png")),
                              onTap: () {
                                // controller.imgFromGallery();
                              },
                            ),
                            GestureDetector(
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: const Offset(1, 1), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                                  ),
                                  child: Image.asset("assets/icons/photo.png")),
                              onTap: () {
                                // controller.imgFromCamera();
                              },
                            ),
                            GestureDetector(
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: const Offset(1, 1), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                                  ),
                                  child: Image.asset("assets/icons/call.png")),
                              onTap: () {
                                controller.callAudio();
                              },
                            ),
                            GestureDetector(
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: const Offset(1, 1), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                                  ),
                                  child: Image.asset("assets/icons/video.png")),
                              onTap: () {
                                // controller.callVideo();
                              },
                            ),
                          ],
                        ))
                    : Container()
              ],
            ),
          ))),
    );
  }
}
