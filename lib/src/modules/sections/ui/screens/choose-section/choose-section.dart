import 'package:Levant_Sale/src/modules/home/ui/screens/home/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/create-ad-choose-section-provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/update-ad-choose-section.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/widgets/categories-display.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/create-ad.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/track-section/track-section-branches.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/root-category.dart';
import '../create-ad/provider.dart';

class SectionChoose extends StatelessWidget {
  final bool create;
  final int? adId;

  const SectionChoose({super.key, required this.create, this.adId});

  @override
  Widget build(BuildContext context) {
    final createProvider =
        Provider.of<CreateAdChooseSectionProvider>(context, listen: false);
    final updateProvider =
        Provider.of<UpdateAdChooseSectionProvider>(context, listen: false);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return FutureBuilder(
      future: homeProvider.getAdById(adId ?? 0),
      builder: (context, snapshot) {
        final ad = snapshot.data;
        print('category name path for ad: ${ad?.categoryNamePath}');
        print('category path for ad: ${ad?.categoryPath}');
        updateProvider.mapCategoriesAndSet(ad?.categoryNamePath ?? '');
        print('category selected: ${updateProvider.selectedCategory}');

        return Consumer<CreateAdProvider>(
          builder: (context, createAdProvider, _) {
            if (createProvider.rootCategories.isEmpty) {
              return const Center(child: Text("No categories available"));
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Consumer<UpdateAdProvider>(
                    builder: (context, updateAdProvider, _) {
                      return CategoriesDisplay(
                        selectable: true,
                        onSectionClicked: () async {
                          create
                              ? createAdProvider.nextStep()
                              : updateAdProvider.nextStep();

                          if (create) {
                            await createProvider.fetchSubcategories(
                              createProvider.selectedCategory?.id ?? 0,
                            );

                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateAdScreen(
                                    lowerWidget: SectionTrack(
                                      subcategories:
                                          createProvider.subcategories,
                                      create: create,
                                    ),
                                  ),
                                ),
                              );
                            });
                          } else {
                            updateAdProvider.nextStep();
                            await updateProvider.fetchSubcategories(
                              updateProvider.selectedCategory?.id ?? 0,
                            );
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateAdScreen(
                                    lowerWidget: SectionTrack(
                                      subcategories:
                                          updateProvider.subcategories,
                                      create: create,
                                    ),
                                  ),
                                ),
                              );
                            });
                          }
                        },
                        create: create,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
