import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/widgets/empty-fav.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/widgets/fav-grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../auth/ui/alerts/alert.dart';
import '../../../../home/ui/screens/ads/ads.dart';
import '../../../../home/ui/screens/home/data.dart';
import '../../../../home/ui/screens/home/widgets/product-section.dart';

class FavoriteScreen extends StatelessWidget {
  static const id = '/fav';
  const FavoriteScreen({super.key});

  Future<String?> _getToken() async {
    return await TokenHelper.getToken();
  }

  Future<void> _loadTags(FavoriteProvider provider, String? token) async {
    if (token != null) {
      await provider.fetchTags(token);
    } else {
      debugPrint('Token not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context, listen: false);

    return FutureBuilder<String?>(
      future: _getToken(),
      builder: (context, tokenSnapshot) {
        if (tokenSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final token = tokenSnapshot.data;

        return FutureBuilder(
          future: _loadTags(provider, token),
          builder: (context, snapshot) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                leadingWidth: 40.w,
                leading: Padding(
                  padding: EdgeInsets.only(left: 16.0.w),
                  child: InkWell(
                    onTap: () =>
                        showNewCollectionAlert(context, provider.tagController),
                    child: SvgPicture.asset(addCircleGreenIcon),
                  ),
                ),
                backgroundColor: Colors.white,
                titleTextStyle: Theme.of(context).textTheme.bodyLarge,
                title: const TitleRow(title: 'المفضلة'),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0.h),
                    child: Column(
                      children: [
                        Consumer<FavoriteProvider>(
                          builder: (context, provider, _) {
                            if (provider.isLoading) {
                              return const CircularProgressIndicator();
                            } else if (provider.tags.isEmpty) {
                              return const EmptyFav();
                            } else {
                              return SizedBox(
                                height: 270.h,
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 1,
                                  ),
                                  itemCount: provider.tags.length,
                                  itemBuilder: (context, index) {
                                    final tag = provider.tags[index];
                                    return CustomGridView(
                                      tag: tag,
                                      token: token ?? tokenTest,
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 30.h),
                        ProductSection(
                          onMorePressed: () =>
                              Navigator.pushNamed(context, AdsScreen.id),
                          isHalfed: true,
                          category: "العروض والخصومات",
                          products: [],
                        ),
                        ProductSection(
                          onMorePressed: () =>
                              Navigator.pushNamed(context, AdsScreen.id),
                          isHalfed: true,
                          category: "الإعلانات الجديدة",
                          products: [],
                        ),
                        ProductSection(
                          onMorePressed: () =>
                              Navigator.pushNamed(context, AdsScreen.id),
                          isHalfed: true,
                          category: "الإعلانات المفترحة",
                          products: [],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
