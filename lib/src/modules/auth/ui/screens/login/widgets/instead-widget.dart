import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants.dart';

class InsteadWidget extends StatelessWidget {
  final String question;
  final String action;
  final String route;
  const InsteadWidget({
    super.key,
    required this.route,
    required this.question,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '$question ',
        children: [
          TextSpan(
            text: action,
            style: TextStyle(
              fontSize: 14.sp,
              color: kprimaryColor,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushReplacementNamed(context, route);
              },
          )
        ],
      ),
    );
  }
}
