import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/tab-bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider.dart';
import 'item-list.dart';

class JoinMyCollection extends StatelessWidget {
  const JoinMyCollection({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TabProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          TabBarWidget(),
          Expanded(
              child: ItemList(
                  provider.buttonText, provider.buttonColor, provider.onPressed,
                  buttonIcon: provider.buttonIcon,
                  buttonTextColor: provider.buttonTextColor)),
        ],
      ),
    );
  }
}
