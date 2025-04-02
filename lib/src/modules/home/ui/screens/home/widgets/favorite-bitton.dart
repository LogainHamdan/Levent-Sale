import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/constants.dart';
import '../provider.dart';

class CustomButton extends StatelessWidget {
  final String productKey;
  final bool favIcon;

  const CustomButton(
      {super.key, required this.productKey, required this.favIcon});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, favoriteProvider, child) {
        final isFav = favoriteProvider.isFavorite(productKey);
        return ClipRRect(
          borderRadius: BorderRadius.circular(18.w),
          child: InkWell(
            onTap: () {
              favoriteProvider.toggleFavorite(productKey);
            },
            customBorder: CircleBorder(),
            child: CircleAvatar(
              radius: 18.w,
              backgroundColor: Colors.white,
              child: Center(
                child: favIcon
                    ? isFav
                        ? SvgPicture.asset(
                            favColoredPath,
                            color: grey4,
                            height: 20.h,
                            width: 20.w,
                          )
                        : SvgPicture.asset(
                            favUncoloredPath,
                            color: grey4,
                            height: 25.h,
                            width: 25.w,
                          )
                    : SvgPicture.asset(
                        shareIcon,
                        height: 20.h,
                        width: 20.w,
                        color: grey3,
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
