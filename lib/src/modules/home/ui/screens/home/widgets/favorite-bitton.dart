import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/constants.dart';
import '../provider.dart';

class FavoriteButton extends StatelessWidget {
  final String productKey; // Now stores a unique key

  const FavoriteButton({Key? key, required this.productKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, favoriteProvider, child) {
        final isFav = favoriteProvider.isFavorite(productKey);
        return Container(
          width: 35.w,
          height: 35.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                spreadRadius: 1,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.red : grey4,
                size: 22.sp,
              ),
              onPressed: () {
                favoriteProvider.toggleFavorite(productKey);
              },
            ),
          ),
        );
      },
    );
  }
}
