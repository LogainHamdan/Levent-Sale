import 'package:Levant_Sale/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../auth/ui/alerts/alert.dart';
import '../../../../home/ui/screens/ads/widgets/products-details.dart';
import '../../../../home/ui/screens/ads/widgets/title-row.dart';
import '../../../../home/ui/screens/home/widgets/search-field.dart';
import '../../../../sections/models/ad.dart';
import '../favorite/provider.dart';

class FavoriteCollectionScreen extends StatelessWidget {
  static const id = '/fav-collection';
  final String tagId;

  const FavoriteCollectionScreen({super.key, required this.tagId});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FavoriteProvider>();

    final filteredFavorites = provider.favorites;

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (filteredFavorites.isEmpty) {
      return const Center(
          child: Text('No favorites found for this collection.'));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 40.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.0.w),
          child: InkWell(
            onTap: () => deleteCollectionAlert(context, tagId),
            child: SvgPicture.asset(deleteCollectionIcon, height: 20.h),
          ),
        ),
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        title: TitleRow(title: 'المفضلة'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: SearchField(
                  width: 327.w,
                  controller: TextEditingController(),
                ),
              ),
              SizedBox(height: 12.h),
              ProductsDetails(productList: filteredFavorites),
            ],
          ),
        ),
      ),
    );
  }
}
