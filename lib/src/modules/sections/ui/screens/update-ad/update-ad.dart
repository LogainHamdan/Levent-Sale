import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/my-collection.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/widgets/stepper-progress.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/widgets/stepper-progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../models/ad.dart';

class UpdateAdScreen extends StatelessWidget {
  static const id = '/update_ad';

  const UpdateAdScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as UpdateAdScreenArgs;
    final provider =
    Provider.of<UpdateAdProvider>(context,
        listen: false);
Future.delayed(Duration(seconds: 1),(){
  provider.resetProgress();
});

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<UpdateAdProvider>(

          builder: (context, provider, child) {

            return Column(
              children: [
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: TitleRow(
                      title: 'تعديل اعلان',
                      additionalBackFunction: () => provider.previousStep()),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: StepperProgressUpdate(
                      currentStep: provider.currentStep,
                      totalSteps: provider.totalSteps),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(child: args.lowerWidget)
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: args.bottomNavBar,
    );
  }
}

class UpdateAdScreenArgs {
  final AdModel ad;
  final Widget bottomNavBar;
  final Widget lowerWidget;

  UpdateAdScreenArgs({
    required this.ad,
    required this.bottomNavBar,
    required this.lowerWidget,
  });
}
