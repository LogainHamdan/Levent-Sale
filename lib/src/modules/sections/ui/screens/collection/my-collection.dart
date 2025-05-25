import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/empty-widget.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/join-collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../config/constants.dart';
import '../../../../auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import '../../../../home/ui/screens/home/provider.dart';
import '../../../../main/ui/screens/main_screen.dart';
import '../create-ad/create-ad.dart';

class MyCollectionScreen extends StatefulWidget {
  static const id = '/collection';

  const MyCollectionScreen({super.key});

  @override
  State<MyCollectionScreen> createState() => _MyCollectionScreenState();
}

class _MyCollectionScreenState extends State<MyCollectionScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserAds();
  }

  Future<void> _fetchUserAds() async {
    try {
      final user = await UserHelper.getUser();
      if (user != null) {
        final userId = user.id;
        final homeProvider = Provider.of<HomeProvider>(context, listen: false);
        final collectionProvider =
            Provider.of<MyCollectionScreenProvider>(context, listen: false);
        await homeProvider.loadUserAds(userId: userId ?? 0);
        await collectionProvider.fetchPendingAds();
        await collectionProvider.fetchPublishedAds();
        await collectionProvider.fetchRejectedAds();
      }
    } catch (e) {
      print('Error fetching user ads: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          titleTextStyle: Theme.of(context).textTheme.bodyLarge,
          leading: SizedBox(),
          title: const TitleRow(
            noBack: true,
            title: 'تشكيلتي',
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: _isLoading
              ? const Center(child: CustomCircularProgressIndicator())
              // : homeProvider.userAds.isEmpty
              //     ? SingleChildScrollView(
              //         child: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             SizedBox(height: 16.h),
              //             EmptyWidget(
              //               msg: 'إعلاناتي فارغة',
              //               img: emptyAdsIcon,
              //               child: Padding(
              //                 padding: EdgeInsets.symmetric(horizontal: 12.0.w),
              //                 child: CustomElevatedButton(
              //                   text: 'ابدأ في انشاء إعلانك',
              //                   onPressed: () => Navigator.pushNamed(
              //                       context, CreateAdScreen.id),
              //                   backgroundColor: kprimaryColor,
              //                   textColor: grey9,
              //                   date: false,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       )
              : JoinMyCollection(),
        ),
      ),
    );
  }
}
