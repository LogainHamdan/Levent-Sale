import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/products-details.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../auth/repos/token-helper.dart';
import '../../../../main/ui/screens/main_screen.dart';
import '../../../../sections/ui/screens/one-section/widgets/horizontal-categories.dart';
import '../home/data.dart';
import '../home/home.dart';
import '../home/provider.dart';
import '../home/widgets/product-item.dart';
import '../home/widgets/search-field.dart';

class AdsScreen extends StatelessWidget {
  static const id = '/id';

   AdsScreen({super.key,});

  @override
  Widget build(BuildContext context) {

    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final token = await TokenHelper.getToken();

      await homeProvider.loadAds(token: token);
    });
    TextEditingController adController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        leading: SizedBox(),
        title: TitleRow(title: 'الاعلانات'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0.w,
                ),
                child: SearchField(
                  width: 327.w,
                  hasFilterIcon: true,
                  controller: adController,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              //   child: HorizontalCategories(),
              // ),
              ProductsDetails(
                productList: homeProvider.allAds,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
