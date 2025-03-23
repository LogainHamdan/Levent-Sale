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
    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      minChildSize: 0.1,
      maxChildSize: 0.6,
      builder: (context, scrollController) {
        return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10.r,
                  spreadRadius: 2.r,
                ),
              ],
            ),
            child: CustomElevatedButton(
              icon: icon,
              text: title,
              onPressed: onPressed,
              backgroundColor: kprimaryColor,
              textColor: Colors.white,
            ));
      },
    );
  }
}
