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
  final List<dynamic> subcategories;

  const SectionTrack({super.key, required this.subcategories});

  @override
  Widget build(BuildContext context) {
    final createAdProvider =
        Provider.of<CreateAdProvider>(context, listen: false);

    final createSectionChooseProvider =
        Provider.of<CreateAdChooseSectionProvider>(context, listen: false);

    final createDetailsProvider =
        Provider.of<CreateAdSectionDetailsProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: () {
          switch (createSectionChooseProvider.currentSelection) {
            case SelectionState.year:
              return createSectionChooseProvider.years.length;
            case SelectionState.yearBrand:
              return createSectionChooseProvider.brands.length;
            case SelectionState.yearBrandModel:
              return createSectionChooseProvider.models.length;
            case SelectionState.yearBrandModelTrans:
              return createSectionChooseProvider.trans.length;
            case SelectionState.none:
              return subcategories.length;
          }
        }(),
        itemBuilder: (context, index) {
          return SizedBox(
            height: 55.h,
            child: CustomCard(
                icon: SvgPicture.asset(height: 15.h, arrowLeftPath),
                title: () {
                  switch (createSectionChooseProvider.currentSelection) {
                    case SelectionState.year:
                      return createSectionChooseProvider.years[index]
                          .toString();
                    case SelectionState.yearBrand:
                      return createSectionChooseProvider.brands[index];
                    case SelectionState.yearBrandModel:
                      return createSectionChooseProvider.models[index];
                    case SelectionState.yearBrandModelTrans:
                      return createSectionChooseProvider.trans[index];
                    case SelectionState.none:
                      return subcategories[index].name;
                  }
                }(),
                onTap: () async {
                  final provider = createSectionChooseProvider;

                  switch (provider.currentSelection) {
                    case SelectionState.year:
                      provider.setSelectedYear(provider.years[index]);
                      print('selected year: ${provider.selectedYear}');
                      break;
                    case SelectionState.yearBrand:
                      provider.setSelectedBrand(provider.brands[index]);
                      print('selected year: ${provider.selectedBrand}');

                      break;
                    case SelectionState.yearBrandModel:
                      provider.setSelectedModel(provider.models[index]);
                      print('selected year: ${provider.selectedModel}');

                      break;
                    case SelectionState.none:
                    default:
                      provider.setSelectedSubcategory(index);
                      debugPrint(
                          "Selected: ${provider.selectedSubcategory?.name}");

                      if (provider.selectedSubcategory != null) {
                        await provider.fetchSubcategories(
                          provider.selectedSubcategory!.id,
                        );
                      } else {
                        print('selected subcategory is null');
                      }
                      break;
                  }
                  final isCar = createSectionChooseProvider.isCar;
                  print(
                      'is Car ${createSectionChooseProvider.selectedSubcategory?.name}$isCar');
                  if (createSectionChooseProvider.subcategories.isEmpty &&
                      !isCar) {
                    createAdProvider.nextStep();

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
                          additionalBackFunction: () {
                            createDetailsProvider.resetAttributes();
                            createSectionChooseProvider.navigateBack();
                          },
                          lowerWidget: SectionDetails1(),
                          bottomNavBar: DraggableButton(
                              color: createAdProvider.isLoading
                                  ? kprimary3Color
                                  : kprimaryColor,
                              createAdProvider.isLoading
                                  ? 'جاري المعالجة'
                                  : 'متابعة', onPressed: () {
                            if (createDetailsProvider
                                .validateFields1(context)) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateAdScreen(
                                          additionalBackFunction: () {},
                                          bottomNavBar: DraggableButton(
                                              color: createAdProvider.isLoading
                                                  ? kprimary3Color
                                                  : kprimaryColor,
                                              createAdProvider.isLoading
                                                  ? 'جاري المعالجة'
                                                  : 'متابعة',
                                              onPressed: () async {
                                            if (createDetailsProvider
                                                .validateFields2(context)) {
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
                                                    ..removeWhere(
                                                        (key, value) =>
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
                                                description:
                                                    createDetailsProvider
                                                        .shortDescController
                                                        .text,
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
                                                governorate:
                                                    address.governorate,
                                                city: address.city,
                                                attributes: filteredAttributes,
                                                fullAddress:
                                                    address.fullAddresse,
                                                adType: createDetailsProvider
                                                        .selectedAdType?.name ??
                                                    AdType.UNKNOWN.name,
                                                currency: createDetailsProvider
                                                    .selectedCurrency?.name,
                                                negotiable:
                                                    createDetailsProvider
                                                        .negotiable,
                                                preferredContactMethod:
                                                    createDetailsProvider
                                                            .selectedContactMethod
                                                            ?.name ??
                                                        ContactMethod
                                                            .EMAIL.name,
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

                                              final response =
                                                  await createAdProvider
                                                      .createAd(
                                                context: context,
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
                  } else if (createSectionChooseProvider
                          .subcategories.isEmpty &&
                      isCar) {
                    if (createSectionChooseProvider.currentSelection ==
                        SelectionState.none) {
                      await createSectionChooseProvider.fetchYears();
                    } else if (createSectionChooseProvider.currentSelection ==
                        SelectionState.year) {
                      await createSectionChooseProvider.fetchBrands();
                    } else if (createSectionChooseProvider.currentSelection ==
                        SelectionState.yearBrand) {
                      await createSectionChooseProvider.fetchModels();
                    } else if (createSectionChooseProvider.currentSelection ==
                        SelectionState.yearBrandModel) {
                      await createSectionChooseProvider.fetchTransmissions();
                    } else if (createSectionChooseProvider.currentSelection ==
                        SelectionState.yearBrandModelTrans) {}
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateAdScreen(
                          additionalBackFunction: () =>
                              createSectionChooseProvider.navigateBack(),
                          lowerWidget: SectionTrack(
                            subcategories: () {
                              final selection =
                                  createSectionChooseProvider.currentSelection;

                              if (selection == SelectionState.year) {
                                return createSectionChooseProvider.years;
                              } else if (selection ==
                                  SelectionState.yearBrand) {
                                return createSectionChooseProvider.brands;
                              } else if (selection ==
                                  SelectionState.yearBrandModel) {
                                return createSectionChooseProvider.models;
                              } else if (selection ==
                                  SelectionState.yearBrandModelTrans) {
                                return createSectionChooseProvider.trans;
                              } else {
                                return [];
                              }
                            }(),
                          ),
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateAdScreen(
                          additionalBackFunction: () =>
                              createSectionChooseProvider.navigateBack(),
                          lowerWidget: SectionTrack(
                            subcategories:
                                createSectionChooseProvider.subcategories,
                          ),
                        ),
                      ),
                    );
                  }
                }),
          );
        },
      ),
    );
  }
}
