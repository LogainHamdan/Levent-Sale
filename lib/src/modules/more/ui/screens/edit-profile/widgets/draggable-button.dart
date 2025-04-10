import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DraggableButton extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final Widget? icon;

  const DraggableButton(this.title,
      {super.key, required this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: DraggableScrollableSheet(
        initialChildSize: 1,
        minChildSize: 0.4,
        maxChildSize: 1.0,
        builder: (context, scrollController) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 6.r,
                  spreadRadius: 2.r,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: CustomElevatedButton(
                    icon: icon,
                    text: title,
                    onPressed: onPressed,
                    backgroundColor: kprimaryColor,
                    textColor: grey9,
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
