import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/item-list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../auth/repos/token-helper.dart';
import '../../../../home/ui/screens/ad-details/ad-details.dart';
import '../../../../home/ui/screens/home/provider.dart';

class ViewScreen extends StatelessWidget {
  const ViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyCollectionScreenProvider>(context);
    var adProvider = Provider.of<MyCollectionScreenProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final token = await TokenHelper.getToken();
      await adProvider.fetchMyAdsByStatus(token ?? '', 'PENDING');
    });
    return ItemList(
      provider.buttonText,
      provider.buttonColor,
      () => Navigator.pushNamed(context, AdDetailsScreen.id),
      buttonIcon: provider.buttonIcon,
      buttonTextColor: provider.buttonTextColor,
    );
  }
}
