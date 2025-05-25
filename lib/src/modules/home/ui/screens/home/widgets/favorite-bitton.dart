import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/create-ad-choose-section-provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/constants.dart';
import '../../../../../auth/repos/token-helper.dart';
import '../../../../../auth/repos/user-helper.dart';
import '../../../../../auth/ui/alerts/alert.dart';
import '../../../../../main/ui/screens/main_screen.dart';
import '../../../../../more/models/profile.dart';
import '../../../../../more/ui/screens/edit-profile/widgets/draggable-button.dart';
import '../../../../../sections/models/ad.dart';
import '../../../../../sections/models/adDTO.dart';
import '../../../../../sections/ui/screens/update-ad/update-ad.dart';
import '../../../../../sections/ui/screens/update-ad/widgets/section-details/provider.dart';
import '../../../../../sections/ui/screens/update-ad/widgets/section-details/section-details1-update.dart';
import '../../../../../sections/ui/screens/update-ad/widgets/section-details/section-details2-update.dart';

class CustomButton extends StatefulWidget {
  final bool favIcon;
  final AdModel? ad;

  const CustomButton({
    super.key,
    required this.favIcon,
    this.ad,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final token = await TokenHelper.getToken();
    // if (token != null && widget.favIcon) {
    //   final provider = Provider.of<FavoriteProvider>(context, listen: false);
    //   final adId = widget.ad?.id ?? 0;
    //   //    await provider.checkFavoriteStatus(adId: adId, authorizationToken: token);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, favoriteProvider, _) {
        final adId = widget.ad?.id ?? 0;
        //   final isFav = favoriteProvider.isFavorite(adId);
        final isFav = widget.ad?.tagId != null ?? false;

        return ClipRRect(
          borderRadius: BorderRadius.circular(18.r),
          child: InkWell(
            onTap: widget.favIcon
                ? () async {
                    final token = await TokenHelper.getToken();
                    if (token == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('يجب تسجيل الدخول أولاً'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (isFav) {
                      await favoriteProvider.deleteFavorite(
                        token: token,
                        favid: '$adId',
                      );
                    } else {
                      print('ad selected: ${widget.ad?.id}');
                      await showAddToFavoriteAlert(
                        context,
                        widget.ad?.id,
                        favoriteProvider.selectedTag?.id ?? '',
                      );
                    }
                  }
                : () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Consumer<UpdateAdProvider>(
                                  builder: (context, provider, child) {
                                    provider.selectAdToUpdate(
                                        widget.ad ?? AdModel());

                                    final adToUpdate =
                                        provider.selectedAdToUpdate ??
                                            AdModel();

                                    print(
                                        'selected ad to update: ${provider.selectedAdToUpdate?.toJson()}');
                                    return UpdateAdScreen(
                                        ad: adToUpdate,
                                        bottomNavBar: DraggableButton('متابعة',
                                            onPressed: () {
                                          final detailsProvider = Provider.of<
                                                  UpdateAdSectionDetailsProvider>(
                                              context,
                                              listen: false);
                                          if (detailsProvider
                                              .validateFields1()) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateAdScreen(
                                                            ad: adToUpdate,
                                                            bottomNavBar:
                                                                DraggableButton(
                                                                    'متابعة',
                                                                    onPressed:
                                                                        () async {
                                                              print(
                                                                  'validate 2: ${detailsProvider.validateFields2()}');
                                                              if (detailsProvider
                                                                  .validateFields2()) {
                                                                final user =
                                                                    await UserHelper
                                                                        .getUser();

                                                                if (user ==
                                                                    null) {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content: Text(
                                                                          "تعذر الحصول على معلومات المستخدم. قم بتسجيل الدخول أولاً."),
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                    ),
                                                                  );
                                                                  return;
                                                                }
                                                                Map<String, dynamic> filteredAttributes = detailsProvider
                                                                    .getAttributeFieldsMap()
                                                                    .map((key,
                                                                            value) =>
                                                                        MapEntry(
                                                                            key,
                                                                            value))
                                                                  ..removeWhere(
                                                                      (key, value) =>
                                                                          value ==
                                                                          null);

                                                                final address = Address(
                                                                    fullAddresse:
                                                                        ' المدينة: ${detailsProvider.selectedCity?.cityName} المحافظة: - ${detailsProvider.selectedGovernorate?.governorateName}',
                                                                    city: detailsProvider
                                                                        .selectedCity,
                                                                    governorate:
                                                                        detailsProvider
                                                                            .selectedGovernorate);
                                                                final ad =
                                                                    AdDTO(
                                                                  title: detailsProvider
                                                                      .titleController
                                                                      .text,
                                                                  description:
                                                                      detailsProvider
                                                                          .shortDescController
                                                                          .text,
                                                                  longDescription:
                                                                      detailsProvider
                                                                          .getQuillText(),
                                                                  contactPhone: detailsProvider
                                                                          .numberMethods
                                                                          .contains(detailsProvider
                                                                              .selectedContactMethod)
                                                                      ? detailsProvider
                                                                          .contactDetailController
                                                                          .text
                                                                      : '',
                                                                  contactEmail: (detailsProvider.emailMethods.contains(detailsProvider
                                                                              .selectedContactMethod) ||
                                                                          detailsProvider.detailMethods.contains(detailsProvider
                                                                              .selectedContactMethod))
                                                                      ? detailsProvider
                                                                          .contactDetailController
                                                                          .text
                                                                      : '',
                                                                  governorate:
                                                                      address
                                                                          .governorate,
                                                                  city: address
                                                                      .city,
                                                                  attributes:
                                                                      filteredAttributes,
                                                                  fullAddress:
                                                                      address
                                                                          .fullAddresse,
                                                                  adType: detailsProvider
                                                                          .selectedAdType
                                                                          ?.name ??
                                                                      AdType
                                                                          .UNKNOWN
                                                                          .name,
                                                                  currency:
                                                                      detailsProvider
                                                                          .selectedCurrency
                                                                          ?.name,
                                                                  negotiable:
                                                                      detailsProvider
                                                                          .negotiable,
                                                                  preferredContactMethod: detailsProvider
                                                                          .selectedContactMethod
                                                                          ?.name ??
                                                                      ContactMethod
                                                                          .EMAIL
                                                                          .name,
                                                                  price: detailsProvider
                                                                      .priceController
                                                                      .text,
                                                                  tradePossible:
                                                                      detailsProvider
                                                                          .tradePossible,
                                                                );

                                                                final token =
                                                                    await TokenHelper
                                                                        .getToken();

                                                                final response = await provider.updateAd(
                                                                    ad,
                                                                    detailsProvider
                                                                        .selectedImages,
                                                                    token:
                                                                        token ??
                                                                            '',
                                                                    id: adToUpdate
                                                                            .id ??
                                                                        0);

                                                                provider
                                                                    .nextStep();

                                                                if (response
                                                                        ?.statusCode ==
                                                                    200) {
                                                                  Navigator.popUntil(
                                                                      context,
                                                                      (route) {
                                                                    return route
                                                                            .settings
                                                                            .name ==
                                                                        MainScreen
                                                                            .id;
                                                                  });

                                                                  showAdUpdated(
                                                                      context);
                                                                }
                                                              }
                                                            }),
                                                            lowerWidget:
                                                                SectionDetails2Update())));
                                          }
                                        }),
                                        lowerWidget: SectionDetails1Update());
                                  },
                                )));
                  },
            customBorder: const CircleBorder(),
            child: CircleAvatar(
              radius: 14.w,
              backgroundColor: Colors.white,
              child: Center(
                child: widget.favIcon
                    ? _buildFavoriteIcon(isFav)
                    : SvgPicture.asset(
                        shareIcon,
                        height: 16.h,
                        width: 16.w,
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFavoriteIcon(bool isFav) {
    return SvgPicture.asset(
      isFav ? favColoredPath : favUncoloredPath,
      height: 14.h,
      width: 14.w,
    );
  }
}
