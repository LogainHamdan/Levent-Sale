import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/widgets/stepper-progress.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/creted-ad-details/created-ad-details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../choose-section/choose-section.dart';
import '../section-details/section-details.dart';
import '../track-section/track-section-branches.dart';

class CreateAdScreen extends StatelessWidget {
  static const id = '/create_ad';

  const CreateAdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StepperProvider(),
      child: Scaffold(
        body: Consumer<StepperProvider>(
          builder: (context, stepper, child) {
            return Column(
              children: [
                SizedBox(height: 30.h),
                TitleRow(title: 'انشاء اعلان'),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                  child: StepperProgress(
                      currentStep: stepper.currentStep,
                      totalSteps: stepper.totalSteps),
                ),
                if (stepper.currentStep == 0)
                  Expanded(child: AdCreatedDetails()),
                if (stepper.currentStep == 1)
                  Expanded(
                      child: SectionTrack(
                    cardListIndex: 0,
                  )),
                if (stepper.currentStep == 2) Expanded(child: SectionDetails()),
                if (stepper.currentStep == 3)
                  Expanded(child: AdCreatedDetails()),
              ],
            );
          },
        ),
      ),
    );
  }
}

// onPressed: stepper.nextStep,
//import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
// import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/choose-section.dart';
// import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/provider.dart';
// import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/widgets/stepper-progress.dart';
// import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/section-details.dart';
// import 'package:Levant_Sale/src/modules/sections/ui/screens/track-section/track-section-branches.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
//
// class CreateAdScreen extends StatelessWidget {
//   static const id = '/create_ad';
//   const CreateAdScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => StepperProvider(),
//       child: Scaffold(
//         body: Consumer<StepperProvider>(
//           builder: (context, stepper, child) {
//             return Column(
//               children: [
//                 SizedBox(height: 30.h),
//                 Text(
//                   'إنشاء إعلان',
//                   style:
//                       TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
//                 ),
//                 Padding(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
//                   child: StepperProgress(
//                       currentStep: stepper.currentStep,
//                       totalSteps: stepper.totalSteps),
//                 ),
//                 if (stepper.currentStep == 0) Expanded(child: SectionChoose()),
//                 if (stepper.currentStep == 1) Expanded(child: SectionTrack()),
//                 if (stepper.currentStep == 2) Expanded(child: SectionDetails()),
//                 if (stepper.currentStep == 3) Expanded(child: CreateAdScreen()),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
//}
