import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/alert.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/widgets/draggable-button.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/section-details2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../home/ui/screens/search-filter/widgets/card.dart';
import '../../../../main/ui/screens/main_screen.dart';
import '../../../../more/models/profile.dart';
import '../../../models/adDTO.dart';
import '../../../models/root-category.dart';
import '../choose-section/create-ad-choose-section-provider.dart';
import '../create-ad/create-ad.dart';
import '../create-ad/provider.dart';
import '../section-details/provider.dart';
import '../section-details/section-details1.dart';

class SectionTrack extends StatelessWidget {
  final List<Category> subcategories;

  const SectionTrack({super.key, required this.subcategories});

  @override
  Widget build(BuildContext context) {
    final createAdProvider = Provider.of<CreateAdProvider>(context);
    final createSectionChooseProvider =
        Provider.of<CreateAdChooseSectionProvider>(context);

    final createDetailsProvider =
        Provider.of<CreateAdSectionDetailsProvider>(context);

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
                createSectionChooseProvider.setSelectedSubcategory(index);
                debugPrint(
                    "Selected: ${createSectionChooseProvider.selectedSubcategory?.name}");

                if (createSectionChooseProvider.selectedSubcategory != null) {
                  await createSectionChooseProvider.fetchSubcategories(
                    createSectionChooseProvider.selectedSubcategory!.id,
                  );
                } else {
                  print('selectd subcategory is null');
                }

                if (createSectionChooseProvider.subcategories.isEmpty) {
                  createAdProvider.nextStep();

                  debugPrint("fetching attributes...");

                  if (createSectionChooseProvider.selectedSubcategory != null) {
                    await createDetailsProvider.fetchAttributes(
                      createSectionChooseProvider.selectedSubcategory!.id,
                    );
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateAdScreen(
                        additionalBackFunction: () {},
                        lowerWidget: SectionDetails1(),
                        bottomNavBar: DraggableButton('متابعة', onPressed: () {
                          if (createDetailsProvider.validateFields1()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateAdScreen(
                                        additionalBackFunction: () {},
                                        bottomNavBar: DraggableButton('متابعة',
                                            onPressed: () async {
                                          if (createDetailsProvider
                                              .validateFields2()) {
                                            final selectedSubCategory =
                                                createSectionChooseProvider
                                                    .selectedSubcategory;
                                            final selectedCategory =
                                                createSectionChooseProvider
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
                                                createDetailsProvider
                                                    .getAttributeFieldsMap()
                                                    .map((key, value) =>
                                                        MapEntry(key, value))
                                                  ..removeWhere((key, value) =>
                                                      value == null);

                                            final address = Address(
                                                fullAddresse:
                                                    ' المدينة: ${createDetailsProvider.selectedCity?.cityName} المحافظة: - ${createDetailsProvider.selectedGovernorate?.governorateName}',
                                                city: createDetailsProvider
                                                    .selectedCity,
                                                governorate:
                                                    createDetailsProvider
                                                        .selectedGovernorate);
                                            print(
                                                'selected category to add: ${selectedCategory.name}');
                                            print(
                                                'selected subcategory to add: ${selectedSubCategory?.name}');
                                            final ad = AdDTO(
                                              title: createDetailsProvider
                                                  .titleController.text,
                                              categoryPath:
                                                  createSectionChooseProvider
                                                      .categoryPath,
                                              description: createDetailsProvider
                                                  .shortDescController.text,
                                              longDescription:
                                                  createDetailsProvider
                                                      .getQuillText(),
                                              contactPhone: createDetailsProvider
                                                      .numberMethods
                                                      .contains(
                                                          createDetailsProvider
                                                              .selectedContactMethod)
                                                  ? createDetailsProvider
                                                      .contactDetailController
                                                      .text
                                                  : '',
                                              contactEmail: (createDetailsProvider
                                                          .emailMethods
                                                          .contains(
                                                              createDetailsProvider
                                                                  .selectedContactMethod) ||
                                                      createDetailsProvider
                                                          .detailMethods
                                                          .contains(
                                                              createDetailsProvider
                                                                  .selectedContactMethod))
                                                  ? createDetailsProvider
                                                      .contactDetailController
                                                      .text
                                                  : '',
                                              governorate: address.governorate,
                                              city: address.city,
                                              attributes: filteredAttributes,
                                              fullAddress: address.fullAddresse,
                                              adType: createDetailsProvider
                                                      .selectedAdType?.name ??
                                                  AdType.UNKNOWN.name,
                                              currency: createDetailsProvider
                                                  .selectedCurrency?.name,
                                              negotiable: createDetailsProvider
                                                  .negotiable,
                                              preferredContactMethod:
                                                  createDetailsProvider
                                                          .selectedContactMethod
                                                          ?.name ??
                                                      ContactMethod.EMAIL.name,
                                              price: createDetailsProvider
                                                  .priceController.text,
                                              tradePossible:
                                                  createDetailsProvider
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

                                            print(
                                                'validate 2: ${createDetailsProvider.validateFields2()}');
                                            final response =
                                                await createAdProvider.createAd(
                                              adDTO: ad,
                                              files: createDetailsProvider
                                                  .selectedImages,
                                              token: token,
                                            );
                                            createAdProvider.nextStep();

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
                      builder: (context) => CreateAdScreen(
                        additionalBackFunction: () {},
                        lowerWidget: SectionTrack(
                          subcategories:
                              createSectionChooseProvider.subcategories,
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
