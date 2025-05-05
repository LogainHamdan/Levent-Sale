import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/item-list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../auth/repos/token-helper.dart';
import '../../../../home/ui/screens/ad-details/ad-details.dart';

class ViewScreen extends StatelessWidget {
  const ViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<MyCollectionScreenProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final token = await TokenHelper.getToken();
      await provider.fetchMyAdsByStatus(
          token: token ?? '', status: 'PUBLISHED');
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
