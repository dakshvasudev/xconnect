import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:x_connect/common/values/values.dart';
import 'package:x_connect/pages/contact/index.dart';
import 'package:x_connect/pages/contact/widgets/contact_list.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});
  AppBar _buildAppBar() {
    return AppBar(
        title: const Text(
      "Contact",
      style: TextStyle(
        color: AppColors.primaryText,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ContactList(),
    );
  }
}
