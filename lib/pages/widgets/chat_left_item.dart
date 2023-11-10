import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:x_connect/common/entities/msgcontent.dart';
import 'package:x_connect/common/routes/names.dart';
import 'package:x_connect/common/utils/date.dart';
import 'package:x_connect/common/values/colors.dart';

Widget LeftRichTextContainer(String textContent) {
  const urlPattern = r"[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:._\+-~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:_\+.~#?&\/\/=]*)";
  List<InlineSpan> widgets = [];

  textContent.splitMapJoin(
    RegExp(urlPattern, caseSensitive: false, multiLine: false),
    onMatch: (Match match) {
      final matchText = match[0];
      if (matchText != null) {
        // widgets.add(TextSpan(recognizer: TapGestureRecognizer()..onTap = () {Uri _url = Uri.parse(matchText);launchUrl(_url); },text: matchText,style: TextStyle(fontSize: 14.sp, color: AppColors.primaryText,decoration: TextDecoration.underline,)));
      }
      return '';
    },
    onNonMatch: (String text) {
      if (text.isNotEmpty) {
        widgets.add(TextSpan(text: text, style: const TextStyle(fontSize: 14, color: AppColors.primaryText)));
      }
      return '';
    },
  );

  return RichText(
    text: TextSpan(children: [...widgets]),
  );
}

Widget ChatLeftItem(Msgcontent item) {
  return Container(
    padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ConstrainedBox(
            constraints: const BoxConstraints(
                maxWidth: 250, //
                minHeight: 40 //
                ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 0, top: 0),
                    padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                    decoration: const BoxDecoration(
                      color: AppColors.primarySecondaryBackground,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: item.type == "text"
                        ? LeftRichTextContainer("${item.content}")
                        : ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 90),
                            child: GestureDetector(
                              child: CachedNetworkImage(imageUrl: "${item.content}"),
                              onTap: () {
                                Get.toNamed(AppRoutes.Photoimgview, parameters: {"url": item.content ?? ""});
                              },
                            )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(item.addtime == null ? "" : duTimeLineFormat((item.addtime as Timestamp).toDate()),
                        style: const TextStyle(fontSize: 10, color: AppColors.primarySecondaryElementText)),
                  )
                ])),
      ],
    ),
  );
}
