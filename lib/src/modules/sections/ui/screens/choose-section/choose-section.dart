import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/create-ad-choose-section-provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/update-ad-choose-section.dart';
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
    final createSectionChooseProvider =
        Provider.of<CreateAdChooseSectionProvider>(context);
    final updateSectionChooseProvider =
        Provider.of<UpdateAdChooseSectionProvider>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          CategoriesDisplay(
            selectable: true,
            onSectionClicked: create
                ? () {
                    createAdProvider.nextStep();
                    createSectionChooseProvider.fetchSubcategories(
                        createSectionChooseProvider.selectedCategory!.id);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateAdScreen(
                                    lowerWidget: SectionTrack(
                                  subcategories:
                                      createSectionChooseProvider.subcategories,
                                  create: true,
                                ))));
                  }
                : () {
                    updateAdProvider.nextStep();
                    updateSectionChooseProvider.fetchSubcategories(
                        updateSectionChooseProvider.selectedCategory!.id);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateAdScreen(
                                    lowerWidget: SectionTrack(
                                  subcategories:
                                      updateSectionChooseProvider.subcategories,
                                  create: false,
                                ))));
                  },
            create: create,
          )
        ],
      ),
    );
    // bottomNavigationBar: CustomBottomNavigationBar
  }
}
