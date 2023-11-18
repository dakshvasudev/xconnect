import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:x_connect/common/routes/names.dart';
import 'package:x_connect/common/values/colors.dart';
import 'package:x_connect/pages/message/controller.dart';

import '../../common/entities/message.dart';
import '../../common/utils/date.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});

  Widget callListItem(CallMessage item) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 0, right: 0, bottom: 10),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: AppColors.primarySecondaryBackground))),
      child: InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                margin: const EdgeInsets.only(top: 0, left: 0, right: 10),
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
                child: item.avatar == null
                    ? const Image(
                        image: AssetImage('assets/images/account_header.png'),
                      )
                    : CachedNetworkImage(
                        imageUrl: item.avatar!,
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
              // 右侧
              Container(
                padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // center
                    SizedBox(
                        width: 175,
                        height: 44,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${item.name}",
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                softWrap: false,
                                style: const TextStyle(
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.thirdElement,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "${item.call_time}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                                style: const TextStyle(
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.primarySecondaryElementText,
                                  fontSize: 12,
                                ),
                              ),
                            ])),
                    SizedBox(
                        width: 85,
                        height: 44,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                item.last_time == null ? "" : duTimeLineFormat((item.last_time as Timestamp).toDate()),
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.thirdElementText,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                item.type == null ? "" : "${item.type}",
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.thirdElementText,
                                  fontSize: 12,
                                ),
                              ),
                            ])),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget chatListItem(Message item) {
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 0, right: 0, bottom: 16),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: AppColors.primarySecondaryBackground))),
      child: InkWell(
          onTap: () {
            if (item.doc_id != null) {
              Get.toNamed("/chat", parameters: {
                "doc_id": item.doc_id!,
                "to_token": item.token!,
                "to_name": item.name!,
                "to_avatar": item.avatar!,
                "to_online": item.online.toString()
              });
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                margin: const EdgeInsets.only(top: 0, left: 0, right: 10),
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
                child: item.avatar == null
                    ? const Image(
                        image: AssetImage('assets/images/account_header.png'),
                      )
                    : CachedNetworkImage(
                        imageUrl: item.avatar!,
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
              // 右侧
              Container(
                padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // center
                    SizedBox(
                        width: 175,
                        height: 44,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${item.name}",
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                softWrap: false,
                                style: const TextStyle(
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.thirdElement,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "${item.last_msg}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                                style: const TextStyle(
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.primarySecondaryElementText,
                                  fontSize: 12,
                                ),
                              ),
                            ])),
                    SizedBox(
                        width: 85,
                        height: 44,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                item.last_time == null ? "" : duTimeLineFormat((item.last_time as Timestamp).toDate()),
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontFamily: 'Avenir',
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.thirdElementText,
                                  fontSize: 12,
                                ),
                              ),
                              item.msg_num == 0
                                  ? Container()
                                  : Container(
                                      padding: const EdgeInsets.only(left: 4, right: 4, top: 0, bottom: 0),
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      ),
                                      child: Text(
                                        "${item.msg_num}",
                                        textAlign: TextAlign.end,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontFamily: 'Avenir',
                                          fontWeight: FontWeight.normal,
                                          color: AppColors.primaryElementText,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                            ])),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget _headBar(double width) {
    return Container(
      width: width,
      height: 70,
      margin: const EdgeInsets.only(bottom: 20, top: 20),
      child: Row(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  controller.goProfile();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: AppColors.primarySecondaryBackground,
                      borderRadius: const BorderRadius.all(Radius.circular(22)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        )
                      ]),
                  child: controller.state.head_detail.value.avatar == null
                      ? const Image(
                          image: AssetImage('assets/images/account_header.png'),
                          fit: BoxFit.fill,
                        )
                      : CachedNetworkImage(
                          imageUrl: controller.state.head_detail.value.avatar!,
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
              ),
              Positioned(
                bottom: 0,
                right: 0,
                height: 14,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primaryElementText,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    color: AppColors.primaryElementStatus,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _headTabs() {
    return Center(
        child: Container(
            width: 320,
            height: 48,
            margin: const EdgeInsets.only(bottom: 0),
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: AppColors.primarySecondaryBackground,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    child: Container(
                      width: 150,
                      height: 40,
                      margin: const EdgeInsets.only(bottom: 0),
                      padding: const EdgeInsets.all(0),
                      decoration: controller.state.tabStatus.value
                          ? BoxDecoration(
                              color: AppColors.primaryBackground,
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: const Offset(0, 2), // changes position of shadow
                                ),
                              ],
                            )
                          : const BoxDecoration(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: const Text(
                              "Chat",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primaryThreeElementText,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      controller.goTabStatus();
                    }),
                GestureDetector(
                    child: Container(
                      width: 150,
                      height: 40,
                      margin: const EdgeInsets.only(bottom: 0),
                      padding: const EdgeInsets.all(0),
                      decoration: controller.state.tabStatus.value
                          ? const BoxDecoration()
                          : BoxDecoration(
                              color: AppColors.primaryBackground,
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: const Offset(0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: const Text(
                              "Call",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      controller.goTabStatus();
                    })
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: Stack(children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  title: _headBar(MediaQuery.of(context).size.width),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 0,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: _headTabs(),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 20,
                  ),
                  sliver: controller.state.tabStatus.value
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(
                          (content, index) {
                            var item = controller.state.msgList[index];
                            return chatListItem(item);
                          },
                          childCount: controller.state.msgList.length,
                        ))
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                          (content, index) {
                            var item = controller.state.callList[index];
                            //controller.state.msgList.length
                            return callListItem(item);
                          },
                          childCount: controller.state.callList.length,
                        )),
                )
              ],
            ),
            Positioned(
              right: 20,
              bottom: 20,
              height: 50,
              width: 50,
              child: GestureDetector(
                child: Container(
                    height: 50,
                    width: 50,
                    padding: const EdgeInsets.all(10),
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
                    child: Image.asset("assets/icons/contact.png")),
                onTap: () {
                  Get.toNamed(AppRoutes.Contact);
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
