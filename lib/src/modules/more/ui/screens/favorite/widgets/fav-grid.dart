import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/widgets/rounded-img.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/constants.dart';
import '../../../../../sections/models/ad.dart';
import '../../../../models/tag.dart';
import '../../fav-collection-screen/fav-collection-screen.dart';

import 'package:provider/provider.dart';

import '../provider.dart';

class CustomGridView extends StatelessWidget {
  final TagModel tag;
  final String token;
  final List<dynamic> favorites;

  const CustomGridView(
      {super.key,
      required this.tag,
      required this.token,
      required this.favorites});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final provider = context.read<FavoriteProvider>();
        provider.setSelectedTag(tag);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FavoriteCollectionScreen(
              tagId: provider.selectedTag!.id ?? '',
            ),
          ),
        );
      },
      child: Consumer<FavoriteProvider>(
        builder: (context, favProvider, child) {
          if (favProvider.isLoading) {
            return CustomCircularProgressIndicator();
          }
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Stack(
              children: [
                if (favorites.isEmpty)
                  const SizedBox()
                else
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: favorites.length > 0
                                ? RoundedImage(
                                    isTopLeft: true,
                                    assetPath:
                                        favorites[0].imageUrls?.first ?? '',
                                  )
                                : const SizedBox(),
                          ),
                          Expanded(
                            child: favorites.length > 1
                                ? RoundedImage(
                                    assetPath:
                                        favorites[1].imageUrls?.first ?? '',
                                    isTopRight: true,
                                  )
                                : const SizedBox(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: favorites.length > 2
                                ? RoundedImage(
                                    assetPath:
                                        favorites[2].imageUrls?.first ?? '',
                                    isBottomLeft: true,
                                  )
                                : const SizedBox(),
                          ),
                          Expanded(
                            child: favorites.length > 3
                                ? RoundedImage(
                                    assetPath:
                                        favorites[3].imageUrls?.first ?? '',
                                    isBottomRight: true,
                                  )
                                : const SizedBox(),
                          ),
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
                      tag.name ?? '',
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
          );
        },
      ),
    );
  }
}
