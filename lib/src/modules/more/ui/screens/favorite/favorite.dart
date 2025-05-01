import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/widgets/empty-fav.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/widgets/fav-grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../auth/ui/alerts/alert.dart';
import '../../../../home/ui/screens/ads/ads.dart';
import '../../../../home/ui/screens/home/widgets/product-section.dart';

class FavoriteScreen extends StatefulWidget {
  static const id = '/fav';
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late FavoriteProvider provider;
  late Future<void> _dataFuture;
  late HomeProvider homeProvider;
  String? token;

  Future<void> _initData() async {
    token = await TokenHelper.getToken();
    if (token != null) {
      await provider.fetchTags(token ?? '');
      for (final tag in provider.tags) {
        await provider.fetchFavoritesByTag(
            token: token ?? '', tagId: tag.id ?? '');
      }
      homeProvider.loadAds();
    } else {
      debugPrint('Token not found');
    }
  }

  @override
  void initState() {
    super.initState();
    provider = Provider.of<FavoriteProvider>(context, listen: false);
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _dataFuture = _initData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

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
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              childAspectRatio: 1,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: provider.tags.length,
                            itemBuilder: (context, index) {
                              final tag = provider.tags[index];
                              final favorites =
                                  provider.tagFavorites[tag.id ?? ''] ?? [];
                              return CustomGridView(
                                favorites: favorites,
                                tag: tag,
                                token: token ?? '',
                              );
                            },
                          );
                        }
                      },
                    ),
                    SizedBox(height: 30.h),
                    ProductSection(
                      onMorePressed: () =>
                          Navigator.pushNamed(context, AdsScreen.id),
                      category: "العروض والخصومات",
                      products: homeProvider.allAds,
                    ),
                    ProductSection(
                      onMorePressed: () =>
                          Navigator.pushNamed(context, AdsScreen.id),
                      category: "الإعلانات الجديدة",
                      products: homeProvider.allAds,
                    ),
                    ProductSection(
                      onMorePressed: () =>
                          Navigator.pushNamed(context, AdsScreen.id),
                      category: "الإعلانات المفترحة",
                      products: homeProvider.allAds,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
