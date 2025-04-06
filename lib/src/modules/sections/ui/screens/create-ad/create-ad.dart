import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/my-collection.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/widgets/stepper-progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../more/ui/screens/edit-profile/widgets/draggable-button.dart';
import '../section-details/section-details.dart';

class CreateAdScreen extends StatelessWidget {
  static const id = '/create_ad';
  final Widget lowerWidget;
  final Widget? bottomNavBar;

  const CreateAdScreen(
      {super.key, required this.lowerWidget, this.bottomNavBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<CreateAdProvider>(
          builder: (context, stepper, child) {
            return Column(
              children: [
                SizedBox(height: 16.h),
                TitleRow(
                    title: 'انشاء اعلان',
                    additionalBackFunction: () => stepper.previousStep()),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: StepperProgress(
                      currentStep: stepper.currentStep,
                      totalSteps: stepper.totalSteps),
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
      bottomNavigationBar: bottomNavBar ?? SizedBox(),
    );
  }
}
