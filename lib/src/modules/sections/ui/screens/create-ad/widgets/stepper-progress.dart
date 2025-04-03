import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepperProgress extends StatelessWidget {
  final int currentStep, totalSteps;

  const StepperProgress({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    List<String> stepTitles = [
      'اختيار القسم',
      'تتبع افرع القسم',
      'نفاصيل القسم',
      'تفاصيل الاعلان'
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection: TextDirection.rtl,
            children: List.generate(totalSteps * 2 - 1, (index) {
              int stepIndex = index ~/ 2;
              bool isStepCompleted = stepIndex < currentStep;
              bool isCurrentStep = stepIndex == currentStep;
              bool isFirstStep = stepIndex == 0;
              bool isLastStep = stepIndex == totalSteps - 1;
              return index.isOdd
                  ? Expanded(
                      child: Container(
                        height: 2.5.h,
                        color: isStepCompleted
                            ? Colors.green.withOpacity(0.6)
                            : Colors.grey.withOpacity(0.3),
                      ),
                    )
                  : Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 8.r,
                              backgroundColor: isStepCompleted ||
                                      (isLastStep &&
                                          currentStep == totalSteps) ||
                                      (isFirstStep && currentStep > 0)
                                  ? Colors.green
                                  : isCurrentStep
                                      ? Colors.green.withOpacity(
                                          0.6) // Faded green when active
                                      : Colors.grey.withOpacity(0.3),
                            ),
                            if (isStepCompleted ||
                                (isLastStep && currentStep == totalSteps) ||
                                (isFirstStep && currentStep > 0))
                              Icon(
                                Icons.check,
                                size: 10.r,
                                color: Colors.white,
                              ),
                          ],
                        ),
                        SizedBox(height: 0.h), // Adjusted for middle alignment
                      ],
                    );
            }),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.rtl,
            children: List.generate(
              totalSteps,
              (index) => Expanded(
                child: Text(
                  maxLines: 2,
                  stepTitles[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: index < currentStep ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
