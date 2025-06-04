import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/chats/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../more/ui/screens/website-info/provider.dart';
import '../provider.dart';

class TabButton extends StatelessWidget {
  final String text;
  final int index;
  final bool info;
  final bool chats;

  const TabButton(
      {super.key,
      required this.text,
      required this.index,
      required this.info,
      required this.chats});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyCollectionScreenProvider>(context);
    var websiteProvider = Provider.of<WebsiteInfoProvider>(context);
    var chatProvider = Provider.of<ChatProvider>(context);
    if (chats) {
      return GestureDetector(
        onTap: () => chatProvider.changeTab(index),
        child: Column(
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: chatProvider.currentIndex == index
                    ? kprimaryColor
                    : Colors.black,
              ),
            ),
            if (chatProvider.currentIndex == index)
              Container(
                height: 3.h,
                width: 60.w,
                color: kprimaryColor,
              ),
          ],
        ),
      );
    } else if (info) {
      return GestureDetector(
        onTap: () => websiteProvider.changeTab(index),
        child: Column(
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: websiteProvider.currentIndex == index
                    ? kprimaryColor
                    : Colors.black,
              ),
            ),
            if (websiteProvider.currentIndex == index)
              Container(
                height: 3.h,
                width: 60.w,
                color: kprimaryColor,
              ),
          ],
        ),
      );
    }
    return GestureDetector(
      onTap: () => provider.changeTab(index),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color:
                  provider.currentIndex == index ? kprimaryColor : Colors.black,
            ),
          ),
          if (provider.currentIndex == index)
            Container(
              height: 3.h,
              width: 60.w,
              color: kprimaryColor,
            ),
        ],
      ),
    );
  }
}
