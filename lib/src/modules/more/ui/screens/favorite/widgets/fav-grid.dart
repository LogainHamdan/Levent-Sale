import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/widgets/rounded-img.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/constants.dart';
import '../../fav-collection-screen/fav-collection-screen.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.pushReplacementNamed(context, FavoriteCollectionScreen.id),
      child: Center(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(2.0.sp),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                children: [
                  RoundedImage(
                      assetPath:
                          'assets/imgs_icons/home/assets/imgs/ايفون4.png',
                      isTopLeft: true),
                  RoundedImage(
                      assetPath:
                          'assets/imgs_icons/home/assets/imgs/ايفون5.png',
                      isTopRight: true),
                  RoundedImage(
                      assetPath:
                          'assets/imgs_icons/home/assets/imgs/ايفون3.png',
                      isBottomLeft: true),
                  RoundedImage(
                      assetPath:
                          'assets/imgs_icons/home/assets/imgs/ايفون2.png',
                      isBottomRight: true),
                ],
              ),
            ),
            Positioned(
              bottom: 2,
              left: 2,
              right: 2,
              child: Container(
                height: 35.h,
                decoration: BoxDecoration(
                    color: grey5,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5.r),
                        bottomLeft: Radius.circular(5.r))),
                padding: EdgeInsets.all(10.sp),
                alignment: Alignment.centerRight,
                child: Text('الأجهزة',
                    style: GoogleFonts.tajawal(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
