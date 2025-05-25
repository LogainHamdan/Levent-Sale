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
        final isFav = widget.ad?.tagId != null;

        return ClipRRect(
          borderRadius: BorderRadius.circular(18.r),
          child: InkWell(
            onTap: widget.favIcon
                ? () async {
                    final token = await TokenHelper.getToken();
                    if (token == null) {
                      loginFirstAlert(context);
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
                    if (widget.ad?.condition?.first?.toLowerCase() ==
                        'published') {
                      final provider =
                          Provider.of<UpdateAdProvider>(context, listen: false);
                      provider.selectAdToUpdate(widget.ad?.id ?? 0, context);
                      Navigator.pushNamed(context, UpdateAdScreen.id);
                    }
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
