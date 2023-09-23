import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:x_connect/common/values/colors.dart';
import 'package:x_connect/pages/message/controller.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});

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
                      : Text('Hi'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  title: _headBar(MediaQuery.of(context).size.width),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
