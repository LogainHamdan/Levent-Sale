import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/widgets/categories-display.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/create-ad.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/track-section/track-section-branches.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../create-ad/provider.dart';

class SectionChoose extends StatelessWidget {
  const SectionChoose({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CreateAdProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          CategoriesDisplay(onSectionClicked: () {
            provider.nextStep();

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateAdScreen(
                        lowerWidget: SectionTrack(cardListIndex: 0))));
          })
        ],
      ),
    );
    // bottomNavigationBar: CustomBottomNavigationBar
  }
}
