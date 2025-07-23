import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/widgets/cutom-druggable-scrollable-sheet.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/widgets/map-section.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/ads.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../../config/constants.dart';
import '../../../../auth/models/user.dart';
import '../../../../auth/ui/alerts/alert.dart';
import '../../../../main/ui/screens/main_screen.dart';
import '../../../../more/models/profile.dart';
import '../../../../more/ui/screens/edit-profile/widgets/draggable-button.dart';
import '../../../../sections/models/ad.dart';
import '../../../../sections/models/adDTO.dart';
import '../../../../sections/ui/screens/update-ad/provider.dart';
import '../../../../sections/ui/screens/update-ad/update-ad.dart';

import '../../../../sections/ui/screens/update-ad/widgets/section-details/provider.dart';
import '../../../../sections/ui/screens/update-ad/widgets/section-details/section-details1-update.dart';
import '../../../../sections/ui/screens/update-ad/widgets/section-details/section-details2-update.dart';
import '../ads/widgets/title-row.dart';
import '../home/provider.dart';
import '../home/widgets/product-section.dart';
import 'widgets/custom-carousel.dart';
import 'widgets/details-section.dart';
import 'widgets/simple-title.dart';
import 'widgets/specifications.dart';

class AdDetailsScreen extends StatelessWidget {
  final int adId;
  static const id = '/ad-details';

  const AdDetailsScreen({super.key, required this.adId});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return FutureBuilder(
        future: Future.wait([
          UserHelper.getUser(),
          homeProvider.getAdById(adId),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                title: Text('تفاصيل الإعلان'),
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: Center(
                child: CustomCircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text('تفاصيل الإعلان'),
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'حدث خطأ في تحميل الإعلان',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        // Retry loading
                        homeProvider.getAdById(adId);
                      },
                      child: Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text('تفاصيل الإعلان'),
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: Center(
                child: CustomCircularProgressIndicator(),
              ),
            );
          }

          final user = snapshot.data![0] as User?;
          final ad = snapshot.data![1] as AdModel?;

          // Update the provider's selected ad if we have valid data
          if (ad != null) {
            homeProvider.selectAd(ad);
          }

          if (ad == null) {
            return Scaffold(
              appBar: AppBar(
                title: Text('تفاصيل الإعلان'),
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'لم يتم العثور على الإعلان',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'قد يكون الإعلان قد تم حذفه أو غير متاح',
                      style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              title: Stack(
                alignment: Alignment.center,
                children: [
                  TitleRow(title: ad.title ?? ''),
                  if (user != null && user.id == ad.userId)
                    Positioned(
                      left: 0,
                      child: Row(
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              final provider = Provider.of<UpdateAdProvider>(
                                  context,
                                  listen: false);
                              provider.selectAdToUpdate(ad.id ?? 0, context);
                              final adToUpdate =
                                  provider.selectedAdToUpdate ?? AdModel();
                              Navigator.pushNamed(
                                context,
                                UpdateAdScreen.id,
                                arguments: UpdateAdScreenArgs(
                                  ad: adToUpdate,
                                  bottomNavBar: DraggableButton(
                                      color: provider.isLoading
                                          ? kprimary3Color
                                          : kprimaryColor,
                                      provider.isLoading
                                          ? 'جاري المعالجة'
                                          : 'متابعة', onPressed: () {
                                    final detailsProvider = Provider.of<
                                            UpdateAdSectionDetailsProvider>(
                                        context,
                                        listen: false);
                                    if (detailsProvider.validateFields1()) {
                                      Navigator.pushNamed(
                                        context,
                                        UpdateAdScreen.id,
                                        arguments: UpdateAdScreenArgs(
                                          ad: adToUpdate,
                                          bottomNavBar: DraggableButton(
                                              color: provider.isLoading
                                                  ? kprimary3Color
                                                  : kprimaryColor,
                                              provider.isLoading
                                                  ? 'جاري المعالجة'
                                                  : 'متابعة',
                                              onPressed: () async {
                                            if (detailsProvider
                                                .validateFields2()) {
                                              Map<String, dynamic>
                                                  filteredAttributes =
                                                  detailsProvider
                                                      .getAttributeFieldsMap()
                                                    ..removeWhere(
                                                        (key, value) =>
                                                            value == null);

                                              final address = Address(
                                                fullAddresse:
                                                    ' المدينة: ${detailsProvider.selectedCity?.cityName} المحافظة: - ${detailsProvider.selectedGovernorate?.governorateName}',
                                                city: detailsProvider
                                                    .selectedCity,
                                                governorate: detailsProvider
                                                    .selectedGovernorate,
                                              );

                                              final ad = AdDTO(
                                                title: detailsProvider
                                                    .titleController.text,
                                                description: detailsProvider
                                                    .shortDescController.text,
                                                longDescription: detailsProvider
                                                    .getQuillText(),
                                                contactPhone: detailsProvider
                                                        .numberMethods
                                                        .contains(detailsProvider
                                                            .selectedContactMethod)
                                                    ? detailsProvider
                                                        .contactDetailController
                                                        .text
                                                    : '',
                                                contactEmail: (detailsProvider
                                                            .emailMethods
                                                            .contains(
                                                                detailsProvider
                                                                    .selectedContactMethod) ||
                                                        detailsProvider
                                                            .detailMethods
                                                            .contains(
                                                                detailsProvider
                                                                    .selectedContactMethod))
                                                    ? detailsProvider
                                                        .contactDetailController
                                                        .text
                                                    : '',
                                                governorate:
                                                    address.governorate,
                                                city: address.city,
                                                attributes: filteredAttributes,
                                                fullAddress:
                                                    address.fullAddresse,
                                                adType: detailsProvider
                                                        .selectedAdType?.name ??
                                                    AdType.UNKNOWN.name,
                                                currency: detailsProvider
                                                    .selectedCurrency?.name,
                                                negotiable:
                                                    detailsProvider.negotiable,
                                                preferredContactMethod:
                                                    detailsProvider
                                                            .selectedContactMethod
                                                            ?.name ??
                                                        ContactMethod
                                                            .EMAIL.name,
                                                price: detailsProvider
                                                    .priceController.text,
                                                tradePossible: detailsProvider
                                                    .tradePossible,
                                              );

                                              final token =
                                                  await TokenHelper.getToken();
                                              final response =
                                                  await provider.updateAd(
                                                      ad,
                                                      detailsProvider
                                                          .selectedImages,
                                                      token: token ?? '',
                                                      id: adToUpdate.id ?? 0);
                                              provider.nextStep();

                                              if (response?.statusCode == 200) {
                                                Navigator.popUntil(
                                                    context,
                                                    (route) =>
                                                        route.settings.name ==
                                                        MainScreen.id);
                                                showAdUpdated(context);
                                              }
                                            }
                                          }),
                                          lowerWidget: SectionDetails2Update(),
                                        ),
                                      );
                                    }
                                  }),
                                  lowerWidget: SectionDetails1Update(),
                                ),
                              );
                            },
                            child: SvgPicture.asset(
                              editBlackIcon,
                              height: 16.h,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          GestureDetector(
                            onTap: () {
                              return deleteAdAlert(context, ad.id ?? 0);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: SvgPicture.asset(
                                deleteCollectionIcon,
                                height: 16.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        Expanded(
                          child: CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomCarousel(
                                      ad: ad,
                                    ),
                                    SizedBox(height: 24.0.h),
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.w),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "${ad.price} ${ad.currency}",
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              'نشر ${timeago.format(ad.createdAt ?? DateTime.now(), locale: 'ar')}',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: grey3,
                                              ),
                                            ),
                                            SizedBox(height: 8.h),
                                            Text(
                                              ad.cleanDescription ?? '',
                                              maxLines: 4,
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: grey2,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 24.h),
                                    SimpleTitle(title: 'التعريفات'),
                                    SizedBox(height: 16.h),
                                    DetailsSection(ad: ad),
                                    SizedBox(height: 24.h),
                                    SimpleTitle(title: 'الوصف'),
                                    SizedBox(height: 12.h),
                                    SpecificationsSection(
                                      title: 'التفاصيل، الفوائد، والتسليم',
                                      specifications: [
                                        ad.cleanLongDescription ?? ''
                                      ],
                                    ),
                                    SizedBox(
                                      height: 24.h,
                                    )
                                  ],
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Column(
                                  children: [
                                    SimpleTitle(
                                      location: true,
                                      title: 'الموقع',
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    FutureBuilder(
                                        future:
                                            homeProvider.getAdByIdForMap(adId),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return CustomCircularProgressIndicator();
                                          }
                                          final adMap = snapshot.data;
                                          return MapSection(
                                              latitude:
                                                  adMap?.latitude?.toString(),
                                              longitude:
                                                  adMap?.longitude?.toString());
                                        }),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                  ],
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: ProductSection(
                                    onMorePressed: () => Navigator.pushNamed(
                                        context, AdsScreen.id),
                                    category: 'مزيد من الإعلانات',
                                    products: homeProvider.allAds),
                              ),
                              SliverToBoxAdapter(
                                child: SizedBox(height: 165.h),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomDraggableScrollableSheet(
                    adId: ad.id ?? 0,
                    userId: ad.userId ?? 0,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
