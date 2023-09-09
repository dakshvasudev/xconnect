import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:x_connect/common/values/colors.dart';

import 'index.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primarySecondaryBackground,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Text(
          'Sign in Page',
        ),
      ),
    );
  }
}
