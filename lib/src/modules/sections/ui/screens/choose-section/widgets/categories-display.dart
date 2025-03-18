import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../config/constants.dart';
import '../../../../../home/ui/screens/home/data.dart';

class CategoriesDisplay extends StatelessWidget {
  const CategoriesDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800.h,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: categoryNames.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.9,
        ),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.0.sp),
                  child: ClipOval(
                    child: Image.asset(
                      categoryImages[index],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                categoryNames[index],
                style: TextStyle(
                    fontSize: 14.sp,
                    color: kprimaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../../../../../home/ui/screens/home/data.dart';
// import '../../create-ad/provider.dart';
//
// class CategoriesDisplay extends StatelessWidget {
//   final bool chooseCase;
//   const CategoriesDisplay({super.key, required this.chooseCase});
//
//   @override
//   Widget build(BuildContext context) {
//     return !chooseCase
//         ? SizedBox(
//       height: 800.h,
//       child: GridView.builder(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: categoryNames.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//           childAspectRatio: 0.9,
//         ),
//         itemBuilder: (context, index) {
//           return Column(
//             children: [
//               Container(
//                 height: 80,
//                 width: 80,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.grey[200],
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 4,
//                       spreadRadius: 1,
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(12.0.sp),
//                   child: ClipOval(
//                     child: Image.asset(
//                       categoryImages[index],
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 5.h),
//               Text(
//                 categoryNames[index],
//                 style: const TextStyle(
//                     fontSize: 14, fontWeight: FontWeight.bold),
//               ),
//             ],
//           );
//         },
//       ),
//     )
//         : ChangeNotifierProvider(
//       create: (_) => StepperProvider(),
//       child: Consumer<StepperProvider>(
//         builder: (context, stepper, child) => SizedBox(
//           height: 800.h,
//           child: GridView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: categoryNames.length,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               crossAxisSpacing: 10,
//               mainAxisSpacing: 10,
//               childAspectRatio: 0.9,
//             ),
//             itemBuilder: (context, index) {
//               return Column(
//                 children: [
//                   InkWell(
//                     onTap: stepper.nextStep,
//                     child: Container(
//                       height: 80.h,
//                       width: 80.w,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.grey[200],
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black12,
//                             blurRadius: 4,
//                             spreadRadius: 1,
//                           ),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.all(12.0.sp),
//                         child: ClipOval(
//                           child: Image.asset(
//                             categoryImages[index],
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 5.h),
//                   Text(
//                     categoryNames[index],
//                     style: const TextStyle(
//                         fontSize: 14, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
