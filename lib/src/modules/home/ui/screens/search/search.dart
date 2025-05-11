import 'package:Levant_Sale/src/modules/home/ui/screens/ads/ads.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/product-section.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/search-field.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/search/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/search/widgets/users-results.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/search/widgets/ads-results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../chats/no-info-widget.dart';
import '../home/data.dart';
import '../home/provider.dart';

class SearchScreen extends StatelessWidget {
  static const id = '/search';
  final bool? users;
  const SearchScreen({super.key, this.users = false});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchProvider>();
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final isUsersSearch = users == true;
    final query = provider.searchController.text.trim();

    final hasNoResults = query.isNotEmpty &&
        ((isUsersSearch && provider.users.isEmpty) ||
            (!isUsersSearch && provider.ads.isEmpty)) &&
        !provider.isLoadingSearch;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Row(
                  children: [
                    SearchField(
                        width: 295,
                        controller: provider.searchController,
                        onChanged: (value) {
                          print("onChanged triggered with: $value");
                          provider.searchAds(query: value, page: 0, size: 8);
                        }),
                    SizedBox(width: 8.w),
                    InkWell(
                      child: Icon(
                        Icons.arrow_forward_outlined,
                        size: 24.sp,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
                SizedBox(height: 24.h),

                // Results / No Results
                if (query.isEmpty)
                  NoInfoWidget(
                    msg: 'ابدأ بكتابة كلمة للبحث',
                    img: searchNoResultIcon,
                  )
                else if (hasNoResults)
                  NoInfoWidget(
                    msg: 'لا يوجد نتائج بحث مطابقة',
                    img: searchNoResultIcon,
                  )
                else
                  isUsersSearch
                      ? const SearchUsersWidget()
                      : const SearchAdsWidget(),

                SizedBox(height: 30.h),

                ProductSection(
                  hasDiscount: false,
                  onMorePressed: () =>
                      Navigator.pushNamed(context, AdsScreen.id),
                  category: "العروض والخصومات",
                  products: homeProvider.allAds,
                ),
                ProductSection(
                  hasDiscount: false,
                  onMorePressed: () =>
                      Navigator.pushNamed(context, AdsScreen.id),
                  category: "الإعلانات الجديدة",
                  products: homeProvider.allAds,
                ),
                ProductSection(
                  hasDiscount: false,
                  onMorePressed: () =>
                      Navigator.pushNamed(context, AdsScreen.id),
                  category: "الإعلانات المقترحة",
                  products: homeProvider.allAds,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
