import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/constants.dart';
import '../../../../../auth/repos/token-helper.dart';
import '../../../../../auth/ui/alerts/alert.dart';
import '../../../../../sections/models/ad.dart';

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
    if (token != null && widget.favIcon) {
      final provider = Provider.of<FavoriteProvider>(context, listen: false);
      final adId = widget.ad?.id ?? 0;
      await provider.checkFavoriteStatus(adId: adId, authorizationToken: token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, favoriteProvider, _) {
        final adId = widget.ad?.id ?? 0;
        final isFav = favoriteProvider.isFavorite(adId);

        return ClipRRect(
          borderRadius: BorderRadius.circular(18.r),
          child: InkWell(
            onTap: () async {
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
                await showAddToFavoriteAlert(
                  context,
                  widget.ad?.id,
                  favoriteProvider.selectedTag?.id ?? '',
                );
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
