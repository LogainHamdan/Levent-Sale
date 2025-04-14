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

  const SectionChoose({super.key, required this.create});

  @override
  Widget build(BuildContext context) {
    final createProvider =
        Provider.of<CreateAdChooseSectionProvider>(context, listen: false);
    final updateProvider =
        Provider.of<CreateAdChooseSectionProvider>(context, listen: false);

    return FutureBuilder(
      future: create
          ? createProvider.fetchCategories()
          : updateProvider.fetchCategories(),
      builder: (context, snapshot) {
        return Consumer<CreateAdProvider>(
          builder: (context, createAdProvider, _) {
            if (create
                ? createProvider.rootCategories.isEmpty
                : updateProvider.rootCategories.isEmpty) {
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
                              createProvider.selectedCategory!.id,
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
                              updateProvider.selectedCategory!.id,
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
