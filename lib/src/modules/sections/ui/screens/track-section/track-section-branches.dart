import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/alert.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/widgets/draggable-button.dart';
import 'package:Levant_Sale/src/modules/sections/models/subcategory.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/my-collection.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/section-details2.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../home/ui/screens/search-filter/widgets/card.dart';
import '../choose-section/create-ad-choose-section-provider.dart';
import '../choose-section/update-ad-choose-section.dart';
import '../create-ad/create-ad.dart';
import '../create-ad/provider.dart';
import '../section-details/create-ad-section-details.dart';
import '../section-details/section-details1.dart';

class SectionTrack extends StatelessWidget {
  final bool create;
  final List<SubcategoryModel> subcategories;

  const SectionTrack(
      {super.key, required this.create, required this.subcategories});

  @override
  Widget build(BuildContext context) {
    final createAdProvider = Provider.of<CreateAdProvider>(context);
    final updateAdProvider = Provider.of<UpdateAdProvider>(context);
    final createSectionChooseProvider =
        Provider.of<CreateAdChooseSectionProvider>(context);
    final updateSectionChooseProvider =
        Provider.of<UpdateAdChooseSectionProvider>(context);
    final createDetailsProvider =
        Provider.of<CreateAdSectionDetailsProvider>(context);
    final updateDetailsProvider =
        Provider.of<UpdateAdChooseSectionProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: subcategories.length,
        itemBuilder: (context, index) {
          return CustomCard(
            onTap: create
                ? () async {
                    createSectionChooseProvider.setSelectedSubcategory(index);
                    debugPrint(
                        "Selected: ${createSectionChooseProvider.selectedSubcategory?.name}");

                    if (createSectionChooseProvider.selectedSubcategory !=
                        null) {
                      await createSectionChooseProvider.fetchSubcategories(
                          createSectionChooseProvider.selectedSubcategory!.id);
                    } else {
                      debugPrint("Selected subcategory is null");
                    }

                    if (createSectionChooseProvider.subcategories.isEmpty) {
                      updateAdProvider.nextStep();

                      debugPrint("fetching attributes...");

                      if (createSectionChooseProvider.selectedSubcategory !=
                          null) {
                        await createDetailsProvider.fetchAttributes(
                          createSectionChooseProvider.selectedSubcategory!.id,
                        );
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateAdScreen(
                            lowerWidget: SectionDetails1(create: create),
                            bottomNavBar: DraggableButton('متابعة',
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CreateAdScreen(
                                            bottomNavBar: DraggableButton(
                                                'متابعة', onPressed: () {
                                              createAdProvider.nextStep();
                                              showAdCreated(context);
                                              Navigator.pushNamed(context,
                                                  MyCollectionScreen.id);
                                            }),
                                            lowerWidget: SectionDetails2(
                                                create: create))))),
                          ),
                        ),
                      );
                    } else {
                      debugPrint(
                          "This is a PARENT node, showing subcategories...");

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateAdScreen(
                            lowerWidget: SectionTrack(
                              subcategories:
                                  createSectionChooseProvider.subcategories,
                              create: create,
                            ),
                          ),
                        ),
                      );
                    }
                  }
                : () async {
                    updateSectionChooseProvider.setSelectedSubcategory(index);

                    if (createSectionChooseProvider.selectedSubcategory !=
                        null) {
                      await updateSectionChooseProvider.fetchSubcategories(
                        updateSectionChooseProvider.selectedSubcategory!.id,
                      );
                    }
                    if (updateSectionChooseProvider.subcategories.isEmpty) {
                      updateAdProvider.nextStep();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateAdScreen(
                                  lowerWidget:
                                      SectionDetails1(create: create))));
                    }
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateAdScreen(
                            lowerWidget: SectionTrack(
                              subcategories:
                                  updateSectionChooseProvider.subcategories,
                              create: create,
                            ),
                          ),
                        ),
                      );
                    });
                  },
            icon: SvgPicture.asset(height: 15.h, arrowLeftPath),
            title: subcategories[index].name,
          );
        },
      ),
    );
  }
}
