import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:x_connect/common/values/colors.dart';
import 'package:x_connect/pages/message/chat/controller.dart';
import 'chat_left_item.dart';
import 'chat_right_item.dart';

class ChatList extends GetView<ChatController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        color: AppColors.primaryBackground,
        padding: const EdgeInsets.only(bottom: 70),
        child: GestureDetector(
          child: CustomScrollView(reverse: true, controller: controller.myscrollController, slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 0,
              ),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                (content, index) {
                  var item = controller.state.msgcontentList[index];
                  if (controller.token == item.token) {
                    return ChatRightItem(item);
                  }
                  return ChatLeftItem(item);
                },
                childCount: controller.state.msgcontentList.length,
              )),
            ),
            SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                sliver: SliverToBoxAdapter(
                  child: controller.state.isloading.value
                      ? Align(
                          alignment: Alignment.center,
                          child: new Text('loading...'),
                        )
                      : Container(),
                )),
          ]),
          onTap: () {
            // controller.close_all_pop();
          },
        )));
  }
}
