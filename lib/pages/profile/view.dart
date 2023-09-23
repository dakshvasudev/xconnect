import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:x_connect/common/values/colors.dart';
import 'package:x_connect/pages/frames/welcome/index.dart';

class ProfilePage extends GetView<WelcomeController> {
  const ProfilePage({super.key});

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Profile',
        style: TextStyle(
          color: AppColors.primaryText,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [],
        ),
      ),
    );
  }
}
