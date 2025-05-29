import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/tab-button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

class TabBarWidget extends StatelessWidget {
  final String tab1;
  final String tab2;
  final String tab3;
  final bool info;
  const TabBarWidget(
      {super.key,
      required this.tab1,
      required this.tab2,
      required this.tab3,
      required this.info});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TabButton(info: info, text: tab1, index: 0),
        TabButton(info: info, text: tab2, index: 1),
        if (!info) TabButton(info: info, text: tab3, index: 2),
      ],
    );
  }
}
