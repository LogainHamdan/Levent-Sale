import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/empty-widget.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/join-collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/constants.dart';
import '../../../../auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import '../../../../main/ui/screens/main_screen.dart';
import '../create-ad/create-ad.dart';

class MyCollectionScreen extends StatelessWidget {
  final bool empty;
  static const id = '/collection';

  const MyCollectionScreen({super.key, required this.empty});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        leading: SizedBox(),
        title: TitleRow(
          title: 'تشكيلتي',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),

            empty
                ? Expanded(
                    child: EmptyWidget(
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
                  ))
                : Expanded(child: JoinMyCollection()),
            // CustomBottomNavigationBar()
          ],
        ),
      ),
    );
  }
}
