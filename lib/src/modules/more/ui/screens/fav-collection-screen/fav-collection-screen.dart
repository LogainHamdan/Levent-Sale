import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/favorite.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../auth/ui/alerts/alert.dart';
import '../../../../home/ui/screens/ads/widgets/products-details.dart';
import '../../../../home/ui/screens/ads/widgets/title-row.dart';
import '../../../../home/ui/screens/home/widgets/search-field.dart';

class FavoriteCollectionScreen extends StatelessWidget {
  static const id = '/fav-collection';

  const FavoriteCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController collectionSearchController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 35.h),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: TitleRow(
                    onBackTap: () =>
                        Navigator.pushNamed(context, FavoriteScreen.id),
                    onSuffixTap: () => deleteCollectionAlert(context),
                    title: 'المفضلة',
                    suffix: Image.asset(
                      'assets/imgs_icons/more/assets/icons/حذف الصورة.png',
                      height: 20.h,
                    ),
                  )),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: SearchField(
                  controller: collectionSearchController,
                ),
              ),
              ProductsDetails()
            ],
          ),
        ),
      ),
    );
  }
}
