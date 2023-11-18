import 'package:cached_network_image/cached_network_image.dart';
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

  Widget _buildNameInput() {
    return Container(
        width: 295,
        height: 44,
        margin: const EdgeInsets.only(bottom: 20, top: 0),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
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
        child: TextField(
          keyboardType: TextInputType.multiline,
          controller: controller.NameEditingController,
          decoration: InputDecoration(
            hintText: controller.state.profile_detail.value.name,
            contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            hintStyle: const TextStyle(
              color: AppColors.primarySecondaryElementText,
            ),
          ),
          style: const TextStyle(
            color: AppColors.primaryText,
            fontFamily: "Avenir",
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          maxLines: 1,
          onChanged: (value) {
            controller.state.profile_detail.value.name = value;
          },
          autocorrect: false,
          // 自动纠正
          obscureText: false, // 隐藏输入内容, 密码框
        ));
  }

  Widget _buildDescripeInput() {
    return Container(
        width: 295,
        height: 44,
        margin: const EdgeInsets.only(bottom: 20, top: 0),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
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
        child: TextField(
          keyboardType: TextInputType.multiline,
          controller: controller.DescriptionEditingController,
          decoration: InputDecoration(
            hintText: controller.state.profile_detail.value.description == null
                ? "Enter a description"
                : controller.state.profile_detail.value.description,
            contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            hintStyle: const TextStyle(
              color: AppColors.primarySecondaryElementText,
            ),
          ),
          style: const TextStyle(
            color: AppColors.primaryText,
            fontFamily: "Avenir",
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          maxLines: 1,
          onChanged: (value) {
            controller.state.profile_detail.value.description = value;
          },
          autocorrect: false,
          // 自动纠正
          obscureText: false, // 隐藏输入内容, 密码框
        ));
  }

  Widget _buildSeleteStatusInput() {
    return Container(
        width: 295,
        height: 44,
        margin: const EdgeInsets.only(bottom: 20, top: 0),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
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
        child: Row(
          children: [
            Container(
              width: 12,
              height: 1,
              margin: const EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                color: controller.state.profile_detail.value.online == 1
                    ? AppColors.primaryElementStatus
                    : AppColors.primarySecondaryElementText,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
            ),
            SizedBox(
                width: 200,
                height: 44,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: controller.state.profile_detail.value.online == 1 ? "Online" : "Offline",
                    hintStyle: const TextStyle(color: AppColors.primarySecondaryElementText),
                    contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  autocorrect: false,
                  // 自动纠正
                  obscureText: false, // 隐藏输入内容, 密码框
                )),
            Container(
              width: 50,
              height: 30,
              padding: const EdgeInsets.only(left: 0),
              decoration: const BoxDecoration(
                  border: Border(
                left: BorderSide(width: 2, color: AppColors.primarySecondaryBackground),
              )),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 35,
                      iconEnabledColor: AppColors.primarySecondaryElementText,
                      hint: const Text(''),
                      elevation: 0,
                      isExpanded: true,
                      // underline:Container(),
                      items: const [
                        DropdownMenuItem(child: Text('Online'), value: 1),
                        DropdownMenuItem(child: Text('Offline'), value: 2),
                      ],
                      onChanged: (value) {
                        controller.state.profile_detail.value.online = value;
                        controller.state.profile_detail.refresh();
                      })),
            )
          ],
        ));
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
          child: controller.state.profile_detail.value.avatar != null
              ? CachedNetworkImage(
                  imageUrl: controller.state.profile_detail.value.avatar!,
                  height: 120,
                  width: 120,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(60)),
                      image: DecorationImage(image: imageProvider, fit: BoxFit.fill
                          // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                          ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Image(
                    image: AssetImage('assets/images/account_header.png'),
                  ),
                )
              : const Image(
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

  Widget _buildLogo(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
        width: 120,
        height: 120,
        margin: const EdgeInsets.only(top: 0, bottom: 50),
        decoration: BoxDecoration(
          color: AppColors.primarySecondaryBackground,
          borderRadius: const BorderRadius.all(Radius.circular(60)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: CachedNetworkImage(
            imageUrl: controller.state.profile_detail.value.avatar!,
            height: 120,
            width: 120,
            imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(60)),
                    image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                  ),
                )),
      ),
      Positioned(
          bottom: 50,
          right: 0,
          height: 35,
          child: GestureDetector(
              child: Container(
                height: 35,
                width: 35,
                padding: const EdgeInsets.all(7),
                decoration: const BoxDecoration(
                  color: AppColors.primaryElement,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: Image.asset(
                  "assets/icons/edit.png",
                ),
              ),
              onTap: () {
                _showPicker(context);
              }))
    ]);
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      controller.imgFromGallery();
                      Get.back();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    controller.imgFromCamera();
                    Get.back();
                  },
                ),
              ],
            ),
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
              child: Column(
                children: [
                  _buildLogo(context),
                  _buildNameInput(),
                  _buildDescripeInput(),
                  _buildSeleteStatusInput(),
                  _buildCompleteBtn(),
                  _buildLogoutBtn()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
