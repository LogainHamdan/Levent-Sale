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

  const CreateAdScreen({super.key, required this.lowerWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<StepperProvider>(
          builder: (context, stepper, child) {
            return Column(
              children: [
                SizedBox(height: 30.h),
                TitleRow(
                    onBackTap: () => Navigator.pushReplacementNamed(
                        context, MyCollectionScreen.id),
                    title: 'انشاء اعلان'),
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
    );
  }
}
