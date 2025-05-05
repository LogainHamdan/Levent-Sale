import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/ad-details.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/custom-action-button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../models/ad.dart';
import '../provider.dart';

class ItemList extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final Widget buttonIcon;

  const ItemList(
    this.buttonText,
    this.buttonColor, {
    super.key,
    required this.buttonIcon,
    required this.buttonTextColor,
  });

  @override
  Widget build(BuildContext context) {
    var adProvider =
        Provider.of<MyCollectionScreenProvider>(context, listen: false);

    return ListView.builder(
        itemCount: adProvider.myAdsByStatus.length,
        itemBuilder: (context, index) {
          final ad = adProvider.myAdsByStatus[index];

          return SizedBox(
            width: 307.w,
            height: 110.h,
            child: Card(
              color: grey8,
              elevation: 0,
              margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 24.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${ad?.price.toString()}',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '${ad?.createdAt?.day}-${ad?.createdAt?.month}-${ad?.createdAt?.year}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: grey3,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 40.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            ad?.title ?? '',
                            textDirection: TextDirection.rtl,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            ad?.categoryNamePath ?? '',
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: grey3,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CustomActionButton(
                              text: buttonText,
                              icon: buttonIcon,
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AdDetailsScreen(adId: ad?.id))),
                              backgroundColor: buttonColor,
                              textColor: buttonTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.r),
                      child: SizedBox(
                          height: 81.h,
                          width: 69.w,
                          child: Image.network(ad?.imageUrls?.first ?? '',
                              fit: BoxFit.cover)),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
