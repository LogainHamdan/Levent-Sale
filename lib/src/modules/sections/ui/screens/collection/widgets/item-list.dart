import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/custom-action-button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemList extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final Function() onPressed;
  final Widget buttonIcon;

  const ItemList(this.buttonText, this.buttonColor, this.onPressed,
      {super.key, required this.buttonIcon, required this.buttonTextColor});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          elevation: 0,
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$41.1',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text('12-7-2025',
                          style: GoogleFonts.tajawal(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'ايفون 14 برو ماكس',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'الاجهزة',
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(height: 5.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomActionButton(
                          text: buttonText,
                          icon: buttonIcon,
                          onPressed: onPressed,
                          backgroundColor: buttonColor,
                          textColor: buttonTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.r),
                  child: SizedBox(
                    height: 120.h,
                    width: 70.w,
                    child: Image.asset(
                      'assets/imgs_icons/home/assets/imgs/ايفون4.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
