import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:x_connect/common/values/colors.dart';
import 'package:x_connect/pages/profile/controller.dart';

class ProfilePage extends GetView<ProfileController> {
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

  Widget _buildProfilePhoto() {
    return Stack(
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: AppColors.primarySecondaryBackground,
            borderRadius: const BorderRadius.all(
              Radius.circular(60),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: const Image(
            image: AssetImage('assets/images/account_header.png'),
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: GestureDetector(
            child: Container(
              height: 35,
              width: 35,
              decoration: const BoxDecoration(
                color: AppColors.primaryElement,
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCompleteBtn() {
    return GestureDetector(
        child: Container(
          width: 295,
          height: 44,
          margin: const EdgeInsets.only(top: 60, bottom: 30),
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: AppColors.primaryElement,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Complete",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryElementText,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          // controller.goSave();
        });
  }

  Widget _buildLogoutBtn() {
    return GestureDetector(
        child: Container(
          width: 295,
          height: 44,
          margin: const EdgeInsets.only(top: 0, bottom: 30),
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: AppColors.primarySecondaryElementText,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Logout",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryElementText,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Get.defaultDialog(
            title: "Are you sure to log out?",
            content: Container(),
            onConfirm: () {
              controller.goLogout();
            },
            onCancel: () {},
            textConfirm: "Confirm",
            textCancel: "Cancel",
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                child: Column(
                  children: [
                    _buildProfilePhoto(),
                    _buildCompleteBtn(),
                    _buildLogoutBtn(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
