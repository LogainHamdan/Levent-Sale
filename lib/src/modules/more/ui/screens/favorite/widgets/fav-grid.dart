import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/widgets/rounded-img.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/constants.dart';
import '../../../../models/tag.dart';
import '../../fav-collection-screen/fav-collection-screen.dart';

import 'package:provider/provider.dart';

import '../provider.dart';

class CustomGridView extends StatelessWidget {
  final TagModel tag;
  final String token;

  const CustomGridView({super.key, required this.tag, required this.token});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final provider = context.read<FavoriteProvider>();
        provider.setSelectedTag(tag);

        await provider.fetchFavoritesByTag(token, tag.id);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FavoriteCollectionScreen(tagId: provider.selectedTag!.id),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: RoundedImage(
                            assetPath: 'assets/imgs/ايفون4.png',
                            isTopLeft: true)),
                    Expanded(
                        child: RoundedImage(
                            assetPath: 'assets/imgs/ايفون5.png',
                            isTopRight: true)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: RoundedImage(
                            assetPath: 'assets/imgs/ايفون3.png',
                            isBottomLeft: true)),
                    Expanded(
                        child: RoundedImage(
                            assetPath: 'assets/imgs/ايفون2.png',
                            isBottomRight: true)),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 35.h,
                decoration: BoxDecoration(
                  color: grey5,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5.r),
                    bottomLeft: Radius.circular(5.r),
                  ),
                ),
                padding: EdgeInsets.all(10.sp),
                alignment: Alignment.centerRight,
                child: Text(
                  tag.name,
                  style: GoogleFonts.tajawal(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
