import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:x_connect/common/values/values.dart';
import 'package:x_connect/pages/frames/message/controller.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});

  Widget _buildPageHeadTitle(String title) {
    return Center(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.primaryElementText,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
          fontSize: 45,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
