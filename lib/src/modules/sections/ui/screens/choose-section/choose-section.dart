import 'package:Levant_Sale/src/modules/home/ui/screens/home/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/create-ad-choose-section-provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/widgets/categories-display.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/create-ad.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/track-section/track-section-branches.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/root-category.dart';
import '../create-ad/provider.dart';

class SectionChoose extends StatelessWidget {
  final int? adId;

  const SectionChoose({super.key, this.adId});

  @override
  Widget build(BuildContext context) {
    final createProvider =
        Provider.of<CreateAdChooseSectionProvider>(context, listen: false);

    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return FutureBuilder(
      future: homeProvider.getAdById(adId ?? 0),
      builder: (context, snapshot) {
        final ad = snapshot.data;
        print('category name path for ad: ${ad?.categoryNamePath}');
        print('category path for ad: ${ad?.categoryPath}');

        return Consumer<CreateAdProvider>(
          builder: (context, createAdProvider, _) {
            if (createProvider.rootCategories.isEmpty) {
              return const Center(child: Text("No categories available"));
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  CategoriesDisplay(
                    selectable: true,
                    onSectionClicked: () async {
                      createAdProvider.nextStep();

                      await createProvider.fetchSubcategories(
                        createProvider.selectedCategory?.id ?? 0,
                      );

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateAdScreen(
                              additionalBackFunction: () {},
                              lowerWidget: SectionTrack(
                                subcategories: createProvider.subcategories,
                              ),
                            ),
                          ),
                        );
                      });
                    },
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
