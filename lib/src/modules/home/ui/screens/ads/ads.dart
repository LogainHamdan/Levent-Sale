import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/products-details.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../main/ui/screens/main_screen.dart';
import '../home/data.dart';
import '../home/home.dart';
import '../home/widgets/product-item.dart';
import '../home/widgets/search-field.dart';

class AdsScreen extends StatelessWidget {
  static const id = '/id';

  const AdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  vertical: 16.h,
                  horizontal: 16.0.w,
                ),
                child: SearchField(
                  width: 327.w,
                  hasFilterIcon: true,
                  controller: adController,
                ),
              ),
              ProductsDetails(
                productList: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
