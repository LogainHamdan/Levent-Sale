import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/ads.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/products-details.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/banner.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/category-list.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-header.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/product-section.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/top-search.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/create-ad-choose-section-provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/create-ad.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/provider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../auth/repos/token-helper.dart';
import '../notifications/provider.dart';
import 'data.dart';

class HomeScreen extends StatelessWidget {
  static const id = '/home';
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          extendBody: true,
          body: SafeArea(
            bottom: false,
            child: RefreshIndicator(
              color: kprimaryColor,
              onRefresh: () async {
                final notificationsProvider =
                    Provider.of<NotificationProvider>(context, listen: false);
                final categoryProvider =
                    Provider.of<CreateAdChooseSectionProvider>(context,
                        listen: false);
                final token = await TokenHelper.getToken();
                await provider.loadAds(token: token);
                await categoryProvider.fetchCategories();
                await notificationsProvider.getNotificationStats(
                    token: token ?? '');
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 12.0.h, right: 10.w, left: 10.w),
                  child: Column(
                    children: [
                      TopSearchBar(),
                      TopBanner(),
                      CategoriesList(),
                      SizedBox(height: 10.h),
                      provider.isLoading
                          ? CustomCircularProgressIndicator()
                          : ProductSection(
                              onMorePressed: () =>
                                  Navigator.pushNamed(context, AdsScreen.id),
                              category: "العروض والخصومات",
                              products: provider.allAds,
                            ),
                      provider.isLoading
                          ? CustomCircularProgressIndicator()
                          : ProductSection(
                              onMorePressed: () =>
                                  Navigator.pushNamed(context, AdsScreen.id),
                              category: "الإعلانات الجديدة",
                              products: provider.allAds,
                            ),
                      CustomHeader(
                          title: 'الاعلانات المقترحة',
                          onPressed: () =>
                              Navigator.pushNamed(context, AdsScreen.id)),
                      provider.isLoading
                          ? CustomCircularProgressIndicator()
                          : ProductsDetails(productList: provider.allAds),
                      SizedBox(
                        height: 40.h,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
