import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/constants.dart';
import '../../../../../auth/repos/token-helper.dart';
import '../../../../../auth/ui/alerts/alert.dart';
import '../../../../../sections/models/ad.dart';

class CustomButton extends StatelessWidget {
  final bool favIcon;
  final AdModel ad;

  const CustomButton({
    super.key,
    required this.favIcon,
    required this.ad,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, favoriteProvider, child) {
        return FutureBuilder<String?>(
          future: TokenHelper.getToken(),
          builder: (context, tokenSnapshot) {
            final token = tokenSnapshot.data;

            return ClipRRect(
              borderRadius: BorderRadius.circular(18.r),
              child: InkWell(
                onTap: () async {
                  try {
                    if (token == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('يجب تسجيل الدخول أولاً')),
                      );
                      return;
                    }

                    // First check current status
                    await favoriteProvider.checkFavoriteStatus(
                      adId: ad.id ?? 0,
                      authorizationToken: token,
                    );

                    if (favoriteProvider.isFavorite) {
                      await favoriteProvider.deleteFavorite('');
                    } else {
                      print(
                          "Attempting to show bottom sheet for adId: ${ad.id ?? 0} and tagId: ${ad.tagId ?? ''}");

                      await showAddToFavoriteAlert(
                          context, ad.id ?? 0, ad.tagId ?? '');
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('حدث خطأ: ${e.toString()}')),
                      );
                    }
                  }
                },
                customBorder: const CircleBorder(),
                child: CircleAvatar(
                  radius: 14.w,
                  backgroundColor: Colors.white,
                  child: Center(
                    child: favIcon
                        ? favoriteProvider.isFavorite
                            ? SvgPicture.asset(
                                favColoredPath,
                                height: 14.h,
                                width: 14.w,
                              )
                            : SvgPicture.asset(
                                favUncoloredPath,
                                height: 16.h,
                                width: 16.w,
                              )
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
      },
    );
  }
}
