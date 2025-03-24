import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/tab-button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TabButton(text: 'المرفوضة', index: 0),
        TabButton(text: 'المقبولة', index: 1),
        TabButton(text: 'قيد المراجعة', index: 2),
      ],
    );
  }
}
