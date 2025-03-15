import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/constants.dart';
import '../provider.dart';

class CustomButton extends StatelessWidget {
  final String productKey;
  final bool favIcon;

  const CustomButton(
      {Key? key, required this.productKey, required this.favIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, favoriteProvider, child) {
        final isFav = favoriteProvider.isFavorite(productKey);
        return Material(
          color: Colors.transparent,
          elevation: 3,
          shape: CircleBorder(),
          child: CircleAvatar(
            radius: 18.w,
            backgroundColor: Colors.white,
            child: Center(
              child: favIcon
                  ? IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: isFav
                          ? Icon(
                              Icons.favorite,
                              color: isFav ? Colors.red : grey4,
                              size: isFav ? 22.sp : 18,
                            )
                          : Image.asset(
                              'assets/imgs_icons/more/assets/icons/heart-uncolored.png',
                              color: grey4,
                            ),
                      onPressed: () {
                        favoriteProvider.toggleFavorite(productKey);
                      },
                    )
                  : IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: Image.asset(
                        'assets/imgs_icons/more/assets/icons/share.png',
                        height: 25.h,
                        width: 25.w,
                        color: grey3,
                      ),
                      onPressed: () {
                        favoriteProvider.toggleFavorite(productKey);
                      },
                    ),
            ),
          ),
        );
      },
    );
  }
}
