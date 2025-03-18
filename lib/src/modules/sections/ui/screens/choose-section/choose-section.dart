import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/widgets/categories-display.dart';
import 'package:flutter/material.dart';
import '../../../../nav-bar/custom_nav_bar.dart';

class SectionChoose extends StatelessWidget {
  static const id = '/choose';

  const SectionChoose({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [CategoriesDisplay()],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
