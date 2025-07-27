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
import '../chats/provider.dart';
import '../notifications/provider.dart';
import 'data.dart';
import 'package:Levant_Sale/src/modules/sections/models/ad.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/provider.dart';

class HomeScreen extends StatelessWidget {
  static const id = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: const _HomeScreenBody(),
    );
  }
}

class _HomeScreenBody extends StatefulWidget {
  const _HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<_HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<_HomeScreenBody> {
  late Future<void> _initFuture;
  String? _token;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _initFuture = _fetchAll();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }


  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) { // 300px قبل النهاية
      final homeProvider = context.read<HomeProvider>();
      if (!homeProvider.isLoadingMore && homeProvider.hasMoreData) {
        homeProvider.loadMoreAds(token: _token);
      }
    }
  }

  Future<void> _fetchAll() async {
    _token = await TokenHelper.getToken();
    final homeProvider = context.read<HomeProvider>();
    await homeProvider.initialize(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('حدث خطأ أثناء تحميل البيانات',
                      style: TextStyle(color: Colors.red)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _initFuture = _fetchAll();
                      });
                    },
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            ),
          );
        }
        return Consumer<HomeProvider>(
          builder: (context, provider, child) {
            return RefreshIndicator(
              onRefresh: () => provider.refreshAds(token: _token),
              color: kprimaryColor,
              child: SafeArea(
                child: ListView(
                  controller: _scrollController, // إضافة الـ controller
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  children: [
                    const TopSearchBar(),
                    const SizedBox(height: 10),
                    const TopBanner(),
                    const SizedBox(height: 10),
                    const CategoriesList(),
                    const SizedBox(height: 10),
                    const _ProductsSections(),
                    const SizedBox(height: 10),
                    const _SuggestedHeaderSection(),
                    const SizedBox(height: 10),
                    const _ProductsDetailsSection(),

                    // Loading indicator في النهاية
                    Consumer<HomeProvider>(
                      builder: (context, provider, child) {
                        if (provider.isLoadingMore) {
                          return const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'جاري تحميل المزيد...',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        // رسالة انتهاء البيانات
                        if (!provider.hasMoreData && provider.allAds.isNotEmpty) {
                          return const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Center(
                              child: Text(
                                'تم عرض جميع الإعلانات',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          );
                        }

                        return const SizedBox(height: 40);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}





class _ProductsSections extends StatelessWidget {
  const _ProductsSections();
  @override
  Widget build(BuildContext context) {
    return Selector<HomeProvider, bool>(
      selector: (_, provider) => provider.isLoading,
      builder: (context, isLoading, child) {
        if (isLoading) return const CustomCircularProgressIndicator();
        return Selector<HomeProvider, List<AdModel>>(
          selector: (_, provider) => provider.allAds,
          builder: (context, allAds, child) {
            return Column(
              children: [
                ProductSection(
                  onMorePressed: () =>
                      Navigator.pushNamed(context, AdsScreen.id,),
                  category: "العروض والخصومات",
                  products: allAds,
                ),
                ProductSection(
                  onMorePressed: () =>
                      Navigator.pushNamed(context, AdsScreen.id),
                  category: "الإعلانات الجديدة",
                  products: allAds,
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _SuggestedHeaderSection extends StatelessWidget {
  const _SuggestedHeaderSection();
  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      title: 'الاعلانات المقترحة',
      onPressed: () => Navigator.pushNamed(context, AdsScreen.id),
    );
  }
}

class _ProductsDetailsSection extends StatelessWidget {
  const _ProductsDetailsSection();
  @override
  Widget build(BuildContext context) {
    return Selector<HomeProvider, bool>(
      selector: (_, provider) => provider.isLoading,
      builder: (context, isLoading, child) {
        if (isLoading) return const CustomCircularProgressIndicator();
        return Consumer<HomeProvider>(
          builder: (context, allAds, child) {
            return ProductsDetails(productList: allAds.allAds);
          },
        );
      },
    );
  }
}
