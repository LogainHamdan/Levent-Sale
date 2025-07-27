import 'package:Levant_Sale/src/modules/sections/ui/screens/cars-sections/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/create-ad-choose-section-provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/provider.dart';
import 'package:flutter/material.dart';

import '../../../../../../config/constants.dart';
import '../../../../../auth/repos/token-helper.dart';
import '../../../../../auth/repos/user-helper.dart';
import '../../../../../auth/ui/alerts/alert.dart';
import '../../../../../main/ui/screens/main_screen.dart';
import '../../../../../more/models/profile.dart';
import '../../../../../more/ui/screens/edit-profile/widgets/draggable-button.dart';
import '../../../../models/adDTO.dart';
import '../../create-ad/create-ad.dart';
import '../../section-details/section-details1.dart';
import '../../section-details/section-details2.dart';

void NavigateToSectionDetails1({
  required BuildContext context,
  required CreateAdSectionDetailsProvider createDetailsProvider,
  required CreateAdChooseSectionProvider createSectionChooseProvider,
  required CreateAdProvider createAdProvider,
  required CarSectionProvider carsProvider,
}) {
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
            color: createAdProvider.isLoading ? kprimary3Color : kprimaryColor,
            createAdProvider.isLoading ? 'جاري المعالجة' : 'متابعة',
            onPressed: () {
          if (createDetailsProvider.validateFields1(context)) {
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
                                : 'متابعة', onPressed: () async {
                          if (createDetailsProvider.validateFields2(context)) {
                            final selectedSubCategory =
                                createSectionChooseProvider.selectedSubcategory;
                            final selectedCategory =
                                createSectionChooseProvider.selectedCategory;

                            final user = await UserHelper.getUser();

                            if (user == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "تعذر الحصول على معلومات المستخدم. قم بتسجيل الدخول أولاً."),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            if (selectedCategory == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("الرجاء اختيار قسم أولاً"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            Map<String, dynamic> filteredAttributes =
                                createDetailsProvider
                                    .getAttributeFieldsMap()
                                    .map((key, value) => MapEntry(key, value))
                                  ..removeWhere((key, value) => value == null);
                            filteredAttributes['السنة'] =
                                createSectionChooseProvider.selectedYear;
                            filteredAttributes['الماركة'] =
                                createSectionChooseProvider.selectedBrand;
                            filteredAttributes['الموديل'] =
                                createSectionChooseProvider.selectedModel;
                            filteredAttributes['ناقل الحركة'] =
                                createSectionChooseProvider.selectedTrans;
                            filteredAttributes['القيادة'] =
                                carsProvider.selectedCar?.drive;
                            filteredAttributes['الاسطوانات'] =
                                carsProvider.selectedCar?.cylinders;
                            filteredAttributes['نوع الوقود'] =
                                carsProvider.selectedCar?.fuelType1;
                            filteredAttributes['فئة حجم المركبة'] =
                                carsProvider.selectedCar?.vehicleSizeClass;
                            filteredAttributes[
                                    'متوسط استهلاك الوقود في المدينة لنوع الوقود'] =
                                carsProvider.selectedCar?.cityMpqForFuelType1;

                            final address = Address(
                                fullAddresse:
                                    ' المدينة: ${createDetailsProvider.selectedCity?.cityName} المحافظة: - ${createDetailsProvider.selectedGovernorate?.governorateName}',
                                city: createDetailsProvider.selectedCity,
                                governorate:
                                    createDetailsProvider.selectedGovernorate);
                            print(
                                'selected category to add: ${selectedCategory.name}');
                            print(
                                'selected subcategory to add: ${selectedSubCategory?.name}');
                            final ad = AdDTO(
                              title: createDetailsProvider.titleController.text,
                              categoryPath:
                                  createSectionChooseProvider.categoryPath,
                              description: createDetailsProvider
                                  .shortDescController.text,
                              longDescription:
                                  createDetailsProvider.getQuillText(),
                              contactPhone: createDetailsProvider.numberMethods
                                      .contains(createDetailsProvider
                                          .selectedContactMethod)
                                  ? createDetailsProvider
                                      .contactDetailController.text
                                  : '',
                              contactEmail: (createDetailsProvider.emailMethods
                                          .contains(createDetailsProvider
                                              .selectedContactMethod) ||
                                      createDetailsProvider.detailMethods
                                          .contains(createDetailsProvider
                                              .selectedContactMethod))
                                  ? createDetailsProvider
                                      .contactDetailController.text
                                  : '',
                              governorate: address.governorate,
                              city: address.city,
                              attributes: filteredAttributes,
                              fullAddress: address.fullAddresse,
                              adType:
                                  createDetailsProvider.selectedAdType?.name ??
                                      AdType.UNKNOWN.name,
                              currency:
                                  createDetailsProvider.selectedCurrency?.name,
                              negotiable: createDetailsProvider.negotiable,
                              preferredContactMethod: createDetailsProvider
                                      .selectedContactMethod?.name ??
                                  ContactMethod.EMAIL.name,
                              price: createDetailsProvider.priceController.text,
                              tradePossible:
                                  createDetailsProvider.tradePossible,
                            );

                            final token = await TokenHelper.getToken();
                            print(token);

                            if (token == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text("قم بتسحيل الدخول اولاً."),
                                    backgroundColor: Colors.red),
                              );
                              return;
                            }

                            final response = await createAdProvider.createAd(
                              context: context,
                              adDTO: ad,
                              files: createDetailsProvider.selectedImages,
                              token: token,
                            );
                            createAdProvider.nextStep();

                            if (response?.statusCode == 200) {
                              Navigator.popUntil(context, (route) {
                                return route.settings.name == MainScreen.id;
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
}
