import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/favorite.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        title: TitleRow(
          suffix: SvgPicture.asset(
            deleteCollectionIcon,
            height: 20.h,
          ),
          onSuffixTap: () => deleteCollectionAlert(context),
          title: 'المفضلة',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: SearchField(
                  width: 327.w,
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
