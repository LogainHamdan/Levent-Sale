import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/widgets/categories-display.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/create-ad.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/track-section/track-section-branches.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../create-ad/provider.dart';

class SectionChoose extends StatelessWidget {
  final bool create;

  const SectionChoose({super.key, required this.create});

  @override
  Widget build(BuildContext context) {
    final createAdProvider = Provider.of<CreateAdProvider>(context);
    final updateAdProvider = Provider.of<UpdateAdProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          CategoriesDisplay(
            selectable: true,
            onSectionClicked: create
                ? () {
                    createAdProvider.nextStep();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateAdScreen(
                                lowerWidget: SectionTrack(
                                    create: true, cardListIndex: 0))));
                  }
                : () {
                    updateAdProvider.nextStep();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateAdScreen(
                                lowerWidget: SectionTrack(
                                    create: false, cardListIndex: 0))));
                  },
            create: create,
          )
        ],
      ),
    );
    // bottomNavigationBar: CustomBottomNavigationBar
  }
}
