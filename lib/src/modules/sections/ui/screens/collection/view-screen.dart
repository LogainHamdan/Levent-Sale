import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/item-list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../home/ui/screens/ad-details/ad-details.dart';

class ViewScreen extends StatelessWidget {
  const ViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyCollectionScreenProvider>(context);
    return ItemList(
      provider.buttonText,
      provider.buttonColor,
      () => Navigator.pushNamed(context, AdDetailsScreen.id),
      buttonIcon: provider.buttonIcon,
      buttonTextColor: provider.buttonTextColor,
    );
  }
}
