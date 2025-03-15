import 'package:flutter/material.dart';

import '../../../../../../config/constants.dart';

class LoginInsteadWidget extends StatelessWidget {
  const LoginInsteadWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(fontWeight: FontWeight.bold),
        text: "لديك حساب؟ ",
        children: [
          TextSpan(
            text: " سجل دخول",
            style: TextStyle(
              color: kprimaryColor,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
