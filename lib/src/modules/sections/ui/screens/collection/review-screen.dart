import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/item-list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../home/ui/screens/ad-details/ad-details.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<MyCollectionScreenProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final token = await TokenHelper.getToken();
      await provider.fetchMyAdsByStatus(token: token ?? '', status: 'REJECTED');
    });

    return SizedBox(
      height: 800.h,
      child: ItemList(
        provider.buttonText,
        provider.buttonColor,
        buttonIcon: provider.buttonIcon,
        buttonTextColor: provider.buttonTextColor,
      ),
    );
  }
}
