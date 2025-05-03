import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
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

class MyCollectionScreen extends StatelessWidget {
  static const id = '/collection';

  const MyCollectionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await homeProvider.loadAds();
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        leading: SizedBox(),
        title: TitleRow(
          noBack: true,
          title: 'تشكيلتي',
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16.h),

              homeProvider.allAds.isEmpty
                  ? EmptyWidget(
                      msg: 'إعلاناتي فارغة',
                      img: emptyAdsIcon,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                        child: CustomElevatedButton(
                          text: 'ابدأ في انشاء إعلانك',
                          onPressed: () =>
                              Navigator.pushNamed(context, CreateAdScreen.id),
                          backgroundColor: kprimaryColor,
                          textColor: grey9,
                          date: false,
                        ),
                      ),
                    )
                  : JoinMyCollection(),
              // CustomBottomNavigationBar()
            ],
          ),
        ),
      ),
    );
  }
}
