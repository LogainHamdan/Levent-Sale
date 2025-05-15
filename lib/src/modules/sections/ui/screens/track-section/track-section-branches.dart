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

import '../../../../home/ui/screens/search-filter/widgets/card.dart';
import '../../../../main/ui/screens/main_screen.dart';
import '../../../../more/models/profile.dart';
import '../../../models/ad.dart';
import '../../../models/adDTO.dart';
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
                                          final selectedSubCategory =
                                              createSectionChooseProvider
                                                  .selectedSubcategory;
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
                                          // final address = Address(
                                          //     governorate: Governorate(
                                          //         name: createDetailsProvider
                                          //             .getSelectedValue(
                                          //                 'المحافظة')),
                                          //     city: City(
                                          //         name: createDetailsProvider
                                          //             .getSelectedValue(
                                          //                 'المدينة')));
                                          final address = Address(
                                              fullAddresse:
                                                  ' المدينة: ${createDetailsProvider.selectedCity?.cityName} المحافظة: - ${createDetailsProvider.selectedGovernorate?.governorateName}',
                                              city: createDetailsProvider
                                                  .selectedCity,
                                              governorate: createDetailsProvider
                                                  .selectedGovernorate);
                                          print(
                                              'selected category to add: ${selectedCategory.name}');
                                          print(
                                              'selected subcategory to add: ${selectedSubCategory?.name}');
                                          final ad = AdDTO(
                                            // createdAt: DateTime.now(),
                                            // updatedAt: DateTime.now(),
                                            // condition: [],
                                            // imageUrls: [],
                                            //      adNo: '',
                                            title: createDetailsProvider
                                                .titleController.text,
                                            categoryPath:
                                                selectedCategory.categoryPath,
                                            // categoryNamePath:
                                            //    selectedCategory
                                            //         .categoryNamePath,
                                            description: createDetailsProvider
                                                .shortDescController.text,
                                            longDescription:
                                                createDetailsProvider
                                                    .contentController.text,
                                            contactPhone: createDetailsProvider
                                                .phoneController.text,
                                            contactEmail: user.email,
                                            // userId: user.id,
                                            // price: int.tryParse(
                                            //         createDetailsProvider
                                            //             .priceController
                                            //             .text) ??
                                            //     0,
                                            governorate: address.governorate,
                                            city: address.city,
                                            attributes: filteredAttributes,
                                            fullAddress: address.fullAddresse,
                                            adType: 'NEW',
                                            // currency: createDetailsProvider
                                            //         .currency ??
                                            currency: createDetailsProvider
                                                .selectedCurrency,
                                            // negotiable: createDetailsProvider
                                            //         .negotiable ?? false,
                                            negotiable: false,

                                            // preferredContactMethod:
                                            //     createDetailsProvider
                                            //             .preferredContactMethod ??
                                            //         'EMAIL',
                                            preferredContactMethod: 'EMAIL',
                                            // tradePossible: createDetailsProvider
                                            //         .tradePossible ??
                                            //     false,
                                            tradePossible: false,
                                          );

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
                                          final response =
                                              await createAdProvider.createAd(
                                            adDTO: ad,
                                            files: createDetailsProvider
                                                .selectedImages,
                                            token: token,
                                          );
                                          // : await updateAdProvider.updateAd(
                                          //     adId: 0,
                                          //     //ان شاء الله..لا تنسي
                                          //     //make a list of user's ads
                                          //     //should be id of the selected ad from user's ads list
                                          //     // make a function for the selected ads in general,
                                          //     // and a function for the selected user's ad
                                          //     adModel: ad,
                                          //     token: token,
                                          //   );

                                          create!
                                              ? createAdProvider.nextStep()
                                              : updateAdProvider.nextStep();
                                          if (create!) {
                                            if (response?.statusCode == 200) {
                                              Navigator.popUntil(context,
                                                  (route) {
                                                return route.settings.name ==
                                                    MainScreen.id;
                                              });

                                              showAdCreated(context);
                                            }
                                          }
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
