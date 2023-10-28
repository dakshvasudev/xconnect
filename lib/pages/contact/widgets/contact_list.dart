import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:x_connect/common/entities/contact.dart';
import 'package:x_connect/common/values/colors.dart';
import 'package:x_connect/pages/contact/controller.dart';

class ContactList extends GetView<ContactController> {
  const ContactList({super.key});
  Widget _buildListItem(ContactItem item) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 0, right: 0, bottom: 0),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: AppColors.primarySecondaryBackground))),
      child: InkWell(
          onTap: () {
            controller.goChat(item);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                child: CachedNetworkImage(
                  imageUrl: item.avatar!,
                  height: 44,
                  width: 44,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(22)),
                      image: DecorationImage(
                        image: imageProvider,
                        // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                      ),
                    ),
                  ),
                ),
              ),
              //
              Container(
                width: 275,
                padding: const EdgeInsets.only(top: 15, left: 10, right: 0, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 200,
                      height: 42,
                      child: Text(
                        "${item.name}",
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: const TextStyle(
                          fontFamily: 'Avenir',
                          fontWeight: FontWeight.bold,
                          color: AppColors.thirdElement,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      width: 12,
                      height: 12,
                      margin: const EdgeInsets.only(top: 5),
                      child: Image.asset(
                        "assets/icons/ang.png",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomScrollView(slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 20,
          ),
          sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
            (content, index) {
              var item = controller.state.contactList[index];
              return _buildListItem(item);
            },
            childCount: controller.state.contactList.length,
          )),
        )
      ]);
    });
  }
}
