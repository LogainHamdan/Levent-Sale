import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WebsiteInfoProvider>(
        builder: (context, provider, child) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: SingleChildScrollView(
                child: Text(
                  provider.privacyPolicy ?? '',
                  textDirection: TextDirection.rtl,
                ),
              ),
            ));
  }
}
