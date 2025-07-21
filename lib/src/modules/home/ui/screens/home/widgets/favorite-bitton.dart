import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/create-ad-choose-section-provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
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

class CustomButton extends StatelessWidget {
  final bool favIcon;
  final AdModel? ad;

  const CustomButton({
    super.key,
    required this.favIcon,
    this.ad,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, favoriteProvider, _) {
        final adId = ad?.id ?? 0;
        final isFav = ad?.tagId != null;

        return ClipRRect(
          borderRadius: BorderRadius.circular(18.r),
          child: InkWell(
            onTap: favIcon
                ? () async {
                    final token = await TokenHelper.getToken();
                    if (token == null) {
                      loginFirstAlert(context);
                      return;
                    }

                    if (isFav) {
                      final tagId = ad?.tagId?.toString() ??
                          favoriteProvider.selectedTag?.id ??
                          '';
                      await favoriteProvider.deleteFavoriteAndRefresh(
                        token: token,
                        favid: '$adId',
                        tagId: tagId,
                      );
                    } else {
                      print('ad selected: ${ad?.id}');
                      await showAddToFavoriteAlert(
                        context,
                        ad?.id,
                        favoriteProvider.selectedTag?.id ?? '',
                      );
                    }
                  }
                : () async {
                    try {
                      await SharePlus.instance.share(ShareParams(
                        text:
                            '${ad?.title ?? ''}\n https://aliyasstore.online/ads/${ad?.id}',
                        subject: ad?.title,
                      ));
                    } catch (e) {
                      print('Sharing failed: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            backgroundColor: errorColor,
                            content: Text(
                              'حدث خطأ في المشاركة',
                              textAlign: TextAlign.center,
                            )),
                      );
                    }
                  },
            customBorder: const CircleBorder(),
            child: CircleAvatar(
              radius: 14.w,
              backgroundColor: Colors.white,
              child: Center(
                child: favIcon
                    ? _buildFavoriteIcon(isFav)
                    : SvgPicture.asset(
                        shareIcon,
                        height: 12.h,
                        width: 12.w,
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
