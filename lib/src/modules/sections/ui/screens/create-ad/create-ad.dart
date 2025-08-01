import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/my-collection.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/widgets/stepper-progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CreateAdScreen extends StatelessWidget {
  static const id = '/create_ad';
  final Widget lowerWidget;
  final Widget? bottomNavBar;
  final Function() additionalBackFunction;

  const CreateAdScreen(
      {super.key,
      required this.lowerWidget,
      this.bottomNavBar,
      required this.additionalBackFunction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<CreateAdProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: TitleRow(
                      title: 'انشاء اعلان',
                      additionalBackFunction: () {
                        provider.previousStep();
                        additionalBackFunction();
                      }),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: StepperProgress(
                      currentStep: provider.currentStep,
                      totalSteps: provider.totalSteps),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(child: lowerWidget)
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom:20.0),
        child: bottomNavBar ?? SizedBox(),
      ),
    );
  }
}
