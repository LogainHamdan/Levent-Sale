import 'package:Levant_Sale/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../more/ui/screens/website-info/provider.dart';
import '../provider.dart';

class TabButton extends StatelessWidget {
  final String text;
  final int index;
  final bool info;

  const TabButton(
      {super.key, required this.text, required this.index, required this.info});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyCollectionScreenProvider>(context);
    var websiteProvider = Provider.of<WebsiteInfoProvider>(context);
    return !info
        ? GestureDetector(
            onTap: () => provider.changeTab(index),
            child: Column(
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: provider.currentIndex == index
                        ? kprimaryColor
                        : Colors.black,
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
          )
        : GestureDetector(
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
}
