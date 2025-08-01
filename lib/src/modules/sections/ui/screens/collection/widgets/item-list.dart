import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/ad-details.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/technical-support.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/custom-action-button.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/update-ad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../auth/repos/token-helper.dart';
import '../../../../../auth/repos/user-helper.dart';
import '../../../../../auth/ui/alerts/alert.dart';
import '../../../../../main/ui/screens/main_screen.dart';
import '../../../../../more/models/profile.dart';
import '../../../../../more/ui/screens/edit-profile/widgets/draggable-button.dart';
import '../../../../models/ad.dart';
import '../../../../models/adDTO.dart';
import '../../update-ad/provider.dart';
import '../../update-ad/widgets/section-details/provider.dart';
import '../../update-ad/widgets/section-details/section-details1-update.dart';
import '../../update-ad/widgets/section-details/section-details2-update.dart';
import '../provider.dart';

class ItemList extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final Widget buttonIcon;
  final List<AdModel?>? ads;

  const ItemList(
    this.buttonText,
    this.buttonColor, {
    super.key,
    required this.buttonIcon,
    required this.buttonTextColor,
    this.ads,
  });

  @override
  Widget build(BuildContext context) {
    final collectionProvider =
        Provider.of<MyCollectionScreenProvider>(context, listen: false);
    return ListView.builder(
        itemCount: ads?.length,
        itemBuilder: (context, index) {
          final ad = ads?[index];

          return SizedBox(
            width: 307.w,
            height: 110.h,
            child: Card(
              color: grey8,
              elevation: 0,
              margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 24.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${ad?.price.toString()}',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '${ad?.createdAt?.day}-${ad?.createdAt?.month}-${ad?.createdAt?.year}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: grey3,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 40.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            ad?.title ?? '',
                            textDirection: TextDirection.rtl,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            ad?.categoryNamePath ?? '',
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: grey3,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CustomActionButton(
                              text: buttonText,
                              icon: buttonIcon,
                              onPressed: () {
                                if (collectionProvider.currentIndex == 0) {
                                  Navigator.pushNamed(
                                      context, TechnicalSupportScreen.id);
                                }
                                if (collectionProvider.currentIndex == 1) {
                                  final provider =
                                      Provider.of<UpdateAdProvider>(context,
                                          listen: false);
                                  provider.selectAdToUpdate(
                                      ad?.id ?? 0, context);
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
                                                print(
                                                    'validate 2: ${detailsProvider.validateFields2()}');
                                                if (detailsProvider
                                                    .validateFields2()) {
                                                  final user = await UserHelper
                                                      .getUser();
                                                  if (user == null) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            "تعذر الحصول على معلومات المستخدم. قم بتسجيل الدخول أولاً."),
                                                        backgroundColor:
                                                            Colors.red,
                                                      ),
                                                    );
                                                    return;
                                                  }

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
                                                        .shortDescController
                                                        .text,
                                                    longDescription:
                                                        detailsProvider
                                                            .getQuillText(),
                                                    contactPhone: detailsProvider
                                                            .numberMethods
                                                            .contains(
                                                                detailsProvider
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
                                                    attributes:
                                                        filteredAttributes,
                                                    fullAddress:
                                                        address.fullAddresse,
                                                    adType: detailsProvider
                                                            .selectedAdType
                                                            ?.name ??
                                                        AdType.UNKNOWN.name,
                                                    currency: detailsProvider
                                                        .selectedCurrency?.name,
                                                    negotiable: detailsProvider
                                                        .negotiable,
                                                    preferredContactMethod:
                                                        detailsProvider
                                                                .selectedContactMethod
                                                                ?.name ??
                                                            ContactMethod
                                                                .EMAIL.name,
                                                    price: detailsProvider
                                                        .priceController.text,
                                                    tradePossible:
                                                        detailsProvider
                                                            .tradePossible,
                                                  );

                                                  final token =
                                                      await TokenHelper
                                                          .getToken();
                                                  final response =
                                                      await provider.updateAd(
                                                          ad,
                                                          detailsProvider
                                                              .selectedImages,
                                                          token: token ?? '',
                                                          id: adToUpdate.id ??
                                                              0);
                                                  provider.nextStep();

                                                  if (response?.statusCode ==
                                                      200) {
                                                    Navigator.popUntil(
                                                        context,
                                                        (route) =>
                                                            route.settings
                                                                .name ==
                                                            MainScreen.id);
                                                    showAdUpdated(context);
                                                  }
                                                }
                                              }),
                                              lowerWidget:
                                                  SectionDetails2Update(),
                                            ),
                                          );
                                        }
                                      }),
                                      lowerWidget: SectionDetails1Update(),
                                    ),
                                  );
                                }
                                if (collectionProvider.currentIndex == 2) {
                                  final provider = Provider.of<HomeProvider>(
                                      context,
                                      listen: false);
                                  provider.selectAd(ad ?? AdModel());
                                  Navigator.pushNamed(
                                      context, AdDetailsScreen.id);
                                }
                              },
                              backgroundColor: buttonColor,
                              textColor: buttonTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.r),
                      child: SizedBox(
                          height: 81.h,
                          width: 69.w,
                          child: Image.network(
                            ad?.imageUrls?.first.trim() ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image);
                            },
                          )),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
