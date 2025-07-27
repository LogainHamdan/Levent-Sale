import 'package:Levant_Sale/src/config/constants.dart';

import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/widgets/draggable-button.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/cars-sections/cars-section.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/cars-sections/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/section-details2.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/track-section/widgets/navigation.dart';
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
    return Consumer<CreateAdProvider>(
      builder: (context, createAdProvider, child) =>
          Consumer<CreateAdChooseSectionProvider>(
        builder: (context, createSectionChooseProvider, child) =>
            Consumer<CreateAdSectionDetailsProvider>(
          builder: (context, createDetailsProvider, child) =>
              Consumer<CarSectionProvider>(
            builder: (context, carsProvider, child) => Padding(
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
                          switch (
                              createSectionChooseProvider.currentSelection) {
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
                          if (createSectionChooseProvider.currentSelection ==
                              SelectionState.yearBrandModelTrans) {
                            provider.setSelectedTrans(provider.trans[index]);

                            await provider.fetchCars();
                            Future.microtask(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateAdScreen(
                                    additionalBackFunction: () {
                                      createSectionChooseProvider
                                          .navigateBack();
                                    },
                                    lowerWidget: CarSection(),
                                    bottomNavBar: DraggableButton('متابعة',
                                        onPressed: () async {
                                      if (carsProvider.selectedCar != null) {
                                        createAdProvider.nextStep();

                                        print(
                                            'selected car: ${carsProvider.selectedCar}');
                                        await createDetailsProvider
                                            .fetchAttributes(
                                                createSectionChooseProvider
                                                        .selectedSubcategory
                                                        ?.id ??
                                                    0);
                                        NavigateToSectionDetails1(
                                            context: context,
                                            createDetailsProvider:
                                                createDetailsProvider,
                                            createSectionChooseProvider:
                                                createSectionChooseProvider,
                                            createAdProvider: createAdProvider,
                                            carsProvider: carsProvider);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                            'قم باختيار السيارة اولاً',
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.center,
                                          ),
                                          backgroundColor: errorColor,
                                        ));
                                      }
                                    }, color: kprimaryColor),
                                  ),
                                ),
                              );
                            });
                            return const SizedBox();
                          }

                          switch (provider.currentSelection) {
                            case SelectionState.year:
                              provider.setSelectedYear(provider.years[index]);
                              print('selected: ${provider.selectedYear}');
                              break;
                            case SelectionState.yearBrand:
                              provider.setSelectedBrand(provider.brands[index]);
                              print('selected: ${provider.selectedBrand}');

                              break;
                            case SelectionState.yearBrandModel:
                              provider.setSelectedModel(provider.models[index]);
                              print('selected: ${provider.selectedModel}');

                              break;
                            case SelectionState.yearBrandModelTrans:
                              provider.setSelectedModel(provider.trans[index]);
                              print('selected: ${provider.selectedTrans}');

                              break;

                            case SelectionState.none:
                              provider.setSelectedSubcategory(index);
                              debugPrint(
                                  "Selected: ${provider.selectedSubcategory?.name}");

                              if (provider.selectedSubcategory != null) {
                                await provider.fetchSubcategories(
                                  provider.selectedSubcategory!.id,
                                );
                              } else {
                                print('selected subcategory is null');
                                print('selected subcategory is null');
                              }
                              break;
                          }
                          final isCar = createSectionChooseProvider.isCar;
                          print(
                              'is Car ${createSectionChooseProvider.selectedSubcategory?.name}$isCar');

                          if (createSectionChooseProvider
                                  .subcategories.isEmpty &&
                              !isCar) {
                            createAdProvider.nextStep();

                            debugPrint("fetching attributes...");

                            if (createSectionChooseProvider
                                    .selectedSubcategory !=
                                null) {
                              await createDetailsProvider.fetchAttributes(
                                createSectionChooseProvider
                                    .selectedSubcategory!.id,
                              );
                            }
                            NavigateToSectionDetails1(
                                context: context,
                                createDetailsProvider: createDetailsProvider,
                                createSectionChooseProvider:
                                    createSectionChooseProvider,
                                createAdProvider: createAdProvider,
                                carsProvider: carsProvider);
                          } else if (createSectionChooseProvider
                                  .subcategories.isEmpty &&
                              isCar) {
                            if (provider.currentSelection ==
                                SelectionState.none) {
                              await provider.fetchYears();
                              _navigateToNextSection(context, provider);
                            } else if (provider.currentSelection ==
                                SelectionState.year) {
                              await provider.fetchBrands();
                              _navigateToNextSection(
                                context,
                                provider,
                              );
                            } else if (provider.currentSelection ==
                                SelectionState.yearBrand) {
                              await provider.fetchModels();
                              _navigateToNextSection(context, provider);
                            } else if (provider.currentSelection ==
                                SelectionState.yearBrandModel) {
                              await provider.fetchTransmissions();

                              _navigateToNextSection(
                                context,
                                provider,
                              );
                            }
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateAdScreen(
                                  additionalBackFunction: () =>
                                      createSectionChooseProvider
                                          .navigateBack(),
                                  lowerWidget: SectionTrack(
                                    subcategories: createSectionChooseProvider
                                        .subcategories,
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToNextSection(
    BuildContext context,
    CreateAdChooseSectionProvider provider,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateAdScreen(
          additionalBackFunction: () => provider.navigateBack(),
          lowerWidget: SectionTrack(
            subcategories: () {
              final selection = provider.currentSelection;
              if (selection == SelectionState.year) {
                return provider.years;
              } else if (selection == SelectionState.yearBrand) {
                return provider.brands;
              } else if (selection == SelectionState.yearBrandModel) {
                return provider.models;
              } else if (selection == SelectionState.yearBrandModelTrans) {
                return provider.trans;
              } else {
                return provider.subcategories;
              }
            }(),
          ),
        ),
      ),
    );
  }
}