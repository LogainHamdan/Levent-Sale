import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/sections/models/subcategory.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../auth/ui/alerts/alert.dart';
import '../../../../home/ui/screens/home/data.dart';
import '../../../../home/ui/screens/search-filter/widgets/card.dart';
import '../../../../home/ui/screens/search-filter/widgets/horizontal-navigate.dart';
import '../../../../more/ui/screens/edit-profile/widgets/draggable-button.dart';
import '../choose-section/create-ad-choose-section-provider.dart';
import '../choose-section/update-ad-choose-section.dart';
import '../create-ad/create-ad.dart';
import '../create-ad/provider.dart';
import '../section-details/section-details.dart';

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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: subcategories.length,
        itemBuilder: (context, index) {
          return CustomCard(
            onTap: create
                ? () async {
                    await createSectionChooseProvider.fetchSubcategories(
                        createSectionChooseProvider.selectedSubcategory!.id);

                    if (createSectionChooseProvider.subcategories.isEmpty) {
                      createAdProvider.nextStep();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateAdScreen(
                                  lowerWidget:
                                      SectionDetails(id: 0, create: create))));
                    }

                    Navigator.push(
                      context,
                      createHorizontalPageRoute(CreateAdScreen(
                        lowerWidget: SectionTrack(
                          subcategories:
                              createSectionChooseProvider.subcategories,
                          create: true,
                        ),
                      )),
                    );
                  }
                : () async {
                    await updateSectionChooseProvider.fetchSubcategories(
                        updateSectionChooseProvider.selectedSubcategory!.id);

                    if (updateSectionChooseProvider.subcategories.isEmpty) {
                      updateAdProvider.nextStep();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateAdScreen(
                                  lowerWidget:
                                      SectionDetails(id: 0, create: create))));
                    }
                    Navigator.push(
                      context,
                      createHorizontalPageRoute(CreateAdScreen(
                        lowerWidget: SectionTrack(
                          subcategories:
                              updateSectionChooseProvider.subcategories,
                          create: false,
                        ),
                      )),
                    );
                  },
            icon: SvgPicture.asset(height: 15.h, arrowLeftPath),
            title: subcategories[index].name,
          );
        },
      ),
    );
  }
}
