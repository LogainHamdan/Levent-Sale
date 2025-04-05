import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../config/constants.dart';
import '../../../../../home/ui/screens/home/data.dart';
import '../../one-section/one-section.dart';

class CategoriesDisplay extends StatelessWidget {
  final Function() onSectionClicked;
  const CategoriesDisplay({super.key, required this.onSectionClicked});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800.h,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: categoryNames.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.9,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: onSectionClicked,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 80.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: grey8,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0.sp),
                    child: ClipOval(
                        child: SvgPicture.asset(
                      categoryImages[index],
                      height: 30.h,
                      width: 30.w,
                      fit: BoxFit.contain,
                    )),
                  ),
                ),
                SizedBox(height: 8.h),
                Flexible(
                  child: Text(
                    categoryNames[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: kprimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
