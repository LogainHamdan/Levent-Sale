import 'dart:io';

import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/alert.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/widgets/draggable-button.dart';
import 'package:Levant_Sale/src/modules/sections/models/subcategory.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/my-collection.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/section-details2.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/update-ad-section-details.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../home/ui/screens/search-filter/widgets/card.dart';
import '../../../models/ad.dart';
import '../choose-section/create-ad-choose-section-provider.dart';
import '../choose-section/update-ad-choose-section.dart';
import '../create-ad/create-ad.dart';
import '../create-ad/provider.dart';
import '../section-details/create-ad-section-details.dart';
import '../section-details/section-details1.dart';

class SectionTrack extends StatelessWidget {
  final bool? create;
  final List<SubcategoryModel> subcategories;

  const SectionTrack(
      {super.key, this.create = true, required this.subcategories});

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
        Provider.of<UpdateAdSectionDetailsProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: subcategories.length,
        itemBuilder: (context, index) {
          return CustomCard(
              icon: SvgPicture.asset(height: 15.h, arrowLeftPath),
              title: subcategories[index].name,
              onTap: () async {
                create!
                    ? createSectionChooseProvider.setSelectedSubcategory(index)
                    : updateSectionChooseProvider.setSelectedSubcategory(index);
                debugPrint(
                    "Selected: ${create! ? createSectionChooseProvider.selectedSubcategory?.name : updateSectionChooseProvider.selectedSubcategory?.name}");

                if (create!) {
                  if (createSectionChooseProvider.selectedSubcategory != null) {
                    await createSectionChooseProvider.fetchSubcategories(
                      createSectionChooseProvider.selectedSubcategory!.id,
                    );
                  } else {
                    print('selectd subcategory is null');
                  }
                } else {
                  if (updateSectionChooseProvider.selectedSubcategory != null) {
                    await updateSectionChooseProvider.fetchSubcategories(
                      updateSectionChooseProvider.selectedSubcategory!.id,
                    );
                  } else {
                    print('selectd subcategory is null');
                  }
                }

                if (create!
                    ? createSectionChooseProvider.subcategories.isEmpty
                    : updateSectionChooseProvider.subcategories.isEmpty) {
                  updateAdProvider.nextStep();

                  debugPrint("fetching attributes...");

                  if (create!
                      ? createSectionChooseProvider.selectedSubcategory != null
                      : updateSectionChooseProvider.selectedSubcategory !=
                          null) {
                    create!
                        ? await createDetailsProvider.fetchAttributes(
                            createSectionChooseProvider.selectedSubcategory!.id,
                          )
                        : await updateDetailsProvider.fetchAttributes(
                            updateSectionChooseProvider.selectedSubcategory!.id,
                          );
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateAdScreen(
                        lowerWidget: SectionDetails1(create: create!),
                        bottomNavBar: DraggableButton('متابعة',
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateAdScreen(
                                        bottomNavBar: DraggableButton('متابعة',
                                            onPressed: () async {
                                          final user =
                                              await UserHelper.getUser();
                                          if (user == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "تعذر الحصول على معلومات المستخدم. قم بتسجيل الدخول أولاً."),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                            return;
                                          }
                                          final selectedCategory =
                                              createSectionChooseProvider
                                                  .selectedCategory;
                                          if (selectedCategory == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "الرجاء اختيار قسم أولاً"),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                            return;
                                          }
                                          Map<String, dynamic>
                                              filteredAttributes =
                                              createDetailsProvider
                                                  .getAttributeFieldsMap()
                                                  .map((key, value) =>
                                                      MapEntry(key, value))
                                                ..removeWhere((key, value) =>
                                                    value == null);

                                          final ad = AdModel(
                                              title: createDetailsProvider
                                                  .titleController.text,
                                              categoryPath:
                                                  createSectionChooseProvider
                                                      .selectedCategory!
                                                      .categoryPath,
                                              categoryNamePath:
                                                  createSectionChooseProvider
                                                      .selectedCategory!
                                                      .categoryNamePath,
                                              description: createDetailsProvider
                                                  .shortDescController.text,
                                              longDescription: createDetailsProvider
                                                  .contentController.text,
                                              contactPhone: createDetailsProvider
                                                  .phoneController.text,
                                              contactEmail: user.email,
                                              userId: user.id,
                                              price: double.tryParse(createDetailsProvider.priceController.text) ??
                                                  0.0,
                                              governorate:
                                                  user.address?.governorate ??
                                                      '',
                                              city: user.address?.city ?? '',
                                              fullAddress:
                                                  user.address?.fullAddress ?? '',
                                              adType: "NEW",
                                              preferredContactMethod: "CALL",
                                              condition: "PUBLISHED",
                                              currency: "SYP",
                                              attributes: filteredAttributes);

                                          final token =
                                              await TokenHelper.getToken();
                                          print(token);

                                          if (token == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      "قم بتسحيل الدخول اولاً."),
                                                  backgroundColor: Colors.red),
                                            );
                                            return;
                                          }

                                          create!
                                              ? await createAdProvider.createAd(
                                                  ad: ad,
                                                  images: createDetailsProvider
                                                      .selectedImages,
                                                  token: token,
                                                )
                                              : await updateAdProvider.updateAd(
                                                  adId: 0,
                                                  //make a list of user's ads
                                                  //should be id of the selected ad from user's ads list
                                                  // make a function for the selected ads in general,
                                                  // and a function for the selected user's ad
                                                  adModel: ad,
                                                  token: token,
                                                );

                                          create!
                                              ? createAdProvider.nextStep()
                                              : updateAdProvider.nextStep();
                                          create!
                                              ? showAdCreated(context)
                                              : Navigator.pushNamed(context,
                                                  MyCollectionScreen.id);
                                        }),
                                        lowerWidget: SectionDetails2(
                                            create: create!))))),
                      ),
                    ),
                  );
                } else {
                  debugPrint("showing subcategories...");

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateAdScreen(
                        lowerWidget: SectionTrack(
                          subcategories: create!
                              ? createSectionChooseProvider.subcategories
                              : updateSectionChooseProvider.subcategories,
                          create: create,
                        ),
                      ),
                    ),
                  );
                }
              });
        },
      ),
    );
  }
}
