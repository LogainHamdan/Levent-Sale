import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/alert.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/widgets/draggable-button.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/section-details2.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/update-ad.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/widgets/choose-section/update-ad-choose-section-provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/widgets/section-details/update-ad-section-details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../../home/ui/screens/search-filter/widgets/card.dart';
import '../../../../../../main/ui/screens/main_screen.dart';
import '../../../../../../more/models/profile.dart';
import '../../../../../models/adDTO.dart';
import '../../../../../models/root-category.dart';
import '../section-details/section-details1.dart';

class SectionTrack extends StatelessWidget {
  final List<Category> subcategories;

  const SectionTrack({super.key, required this.subcategories});

  @override
  Widget build(BuildContext context) {
    final updateProvider = Provider.of<UpdateAdProvider>(context);
    final updateSectionChooseProvider =
        Provider.of<UpdateAdChooseSectionProvider>(context);

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
                updateSectionChooseProvider.setSelectedSubcategory(index);
                debugPrint(
                    "Selected: ${updateSectionChooseProvider.selectedSubcategory?.name}");

                if (updateSectionChooseProvider.selectedSubcategory != null) {
                  await updateSectionChooseProvider.fetchSubcategories(
                    updateSectionChooseProvider.selectedSubcategory!.id,
                  );
                } else {
                  print('selectd subcategory is null');
                }

                if (updateSectionChooseProvider.subcategories.isEmpty) {
                  updateProvider.nextStep();

                  debugPrint("fetching attributes...");

                  if (updateSectionChooseProvider.selectedSubcategory != null) {
                    await updateDetailsProvider.fetchAttributes(
                      updateSectionChooseProvider.selectedSubcategory!.id,
                    );
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateAdScreen(
                        adId: 0,
                        lowerWidget: SectionDetails1(),
                        bottomNavBar: DraggableButton('متابعة', onPressed: () {
                          if (updateDetailsProvider.validateFields1()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateAdScreen(
                                        adId: 0,
                                        bottomNavBar: DraggableButton('متابعة',
                                            onPressed: () async {
                                          print(
                                              'validate 2: ${updateDetailsProvider.validateFields2()}');
                                          if (updateDetailsProvider
                                              .validateFields2()) {
                                            final selectedSubCategory =
                                                updateSectionChooseProvider
                                                    .selectedSubcategory;
                                            final selectedCategory =
                                                updateSectionChooseProvider
                                                    .selectedCategory;

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
                                                updateDetailsProvider
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
                                                    ' المدينة: ${updateDetailsProvider.selectedCity?.cityName} المحافظة: - ${updateDetailsProvider.selectedGovernorate?.governorateName}',
                                                city: updateDetailsProvider
                                                    .selectedCity,
                                                governorate:
                                                    updateDetailsProvider
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
                                              title: updateDetailsProvider
                                                  .titleController.text,
                                              categoryPath:
                                                  selectedCategory.categoryPath,
                                              description: updateDetailsProvider
                                                  .shortDescController.text,
                                              longDescription:
                                                  updateDetailsProvider
                                                      .getQuillText(),

                                              contactPhone: updateDetailsProvider
                                                      .numberMethods
                                                      .contains(
                                                          updateDetailsProvider
                                                              .selectedContactMethod)
                                                  ? updateDetailsProvider
                                                      .contactDetailController
                                                      .text
                                                  : '',
                                              contactEmail: (updateDetailsProvider
                                                          .emailMethods
                                                          .contains(
                                                              updateDetailsProvider
                                                                  .selectedContactMethod) ||
                                                      updateDetailsProvider
                                                          .detailMethods
                                                          .contains(
                                                              updateDetailsProvider
                                                                  .selectedContactMethod))
                                                  ? updateDetailsProvider
                                                      .contactDetailController
                                                      .text
                                                  : '',

                                              governorate: address.governorate,
                                              city: address.city,
                                              attributes: filteredAttributes,
                                              fullAddress: address.fullAddresse,
                                              adType: updateDetailsProvider
                                                      .selectedAdType?.name ??
                                                  AdType.UNKNOWN.name,

                                              currency: updateDetailsProvider
                                                  .selectedCurrency,

                                              negotiable: updateDetailsProvider
                                                  .negotiable,
                                              preferredContactMethod:
                                                  updateDetailsProvider
                                                          .selectedContactMethod
                                                          ?.name ??
                                                      ContactMethod.EMAIL.name,
                                              price: updateDetailsProvider
                                                  .priceController.text,

                                              tradePossible:
                                                  updateDetailsProvider
                                                      .tradePossible,
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
                                                    backgroundColor:
                                                        Colors.red),
                                              );
                                              return;
                                            }
                                            print('to create invoke');

                                            final response =
                                                await updateProvider.createAd(
                                              adDTO: ad,
                                              files: updateDetailsProvider
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

                                            updateProvider.nextStep();

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
                                        lowerWidget: SectionDetails2())));
                          }
                        }),
                      ),
                    ),
                  );
                } else {
                  debugPrint("showing subcategories...");

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateAdScreen(
                        adId: 0,
                        lowerWidget: SectionTrack(
                            subcategories:
                                updateSectionChooseProvider.subcategories),
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
