import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tajawal/src/modules/auth/ui/screens/sign-up/widgets/custom-pass-field.dart';
import 'package:tajawal/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import '../../../../../../config/constants.dart';
import '../../sign-up/widgets/custom-text-field.dart';

void showPasswordUpdated(BuildContext context) {
  if (!context.mounted) return;

  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.2),
    builder: (dialogContext) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(dialogContext).pop(),
                    child: Image.asset(
                      'lib/src/modules/auth/ui/assets/icons/cancel.png',
                      height: 20.h,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0.h),
                child: Image.asset(
                  'lib/src/modules/auth/ui/assets/imgs/tick.png',
                  height: 100.h,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'تم تحديث كلمة المرور',
                textDirection: TextDirection.rtl,
                style: GoogleFonts.tajawal(
                    color: kprimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.sp),
              ),
              SizedBox(height: 5.h),
              Text(
                textAlign: TextAlign.center,
                'لقد تم تحديث كلمة المرور الخاصة بك',
                textDirection: TextDirection.rtl,
                style: GoogleFonts.tajawal(color: grey4, fontSize: 15.sp),
              ),
              SizedBox(height: 25.h),
              CustomButton(
                text: 'تسجيل دخول',
                onPressed: () => Navigator.of(dialogContext).pop(),
                backgroundColor: kprimaryColor,
                textColor: Colors.white,
                date: false,
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showSetNewPassword(BuildContext context) {
  TextEditingController firstController = TextEditingController();
  TextEditingController secondController = TextEditingController();
  TextEditingController thirdController = TextEditingController();

  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.2),
    builder: (dialogContext) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(dialogContext).pop(),
                    child: Image.asset(
                      'lib/src/modules/auth/ui/assets/icons/cancel.png',
                      height: 20.h,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0.h),
                child: Text(
                  'تعيين كلمة المرور',
                  style: GoogleFonts.tajawal(
                      color: kprimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.sp),
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                textAlign: TextAlign.center,
                'قم بإدخال كلمة المرور الجديدة ومن ثم تأكيدها مرة أخرى',
                style: GoogleFonts.tajawal(color: grey4, fontSize: 15.sp),
              ),
              CustomTextField(
                  controller: firstController, hint: 'أدخل الرمز المرسل'),
              CustomPasswordField(
                  controller: secondController, hint: 'كلمة المرور الجديدة'),
              CustomPasswordField(
                  controller: thirdController,
                  hint: 'تأكيد كلمة المرور الجديدة'),
              SizedBox(height: 25.h),
              CustomButton(
                text: 'تأكيد',
                onPressed: () {},
                backgroundColor: kprimaryColor,
                textColor: Colors.white,
                date: false,
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showForgotPassword(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.2),
    builder: (dialogContext) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(dialogContext).pop(),
                    child: Image.asset(
                      'lib/src/modules/auth/ui/assets/icons/cancel.png',
                      height: 20.h,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0.h),
                child: Text(
                  'نسيت كلمة المرور',
                  style: GoogleFonts.tajawal(
                      color: kprimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.sp),
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                textAlign: TextAlign.center,
                'أدخل البريد الإلكتروني الخاص بك وسنقوم بإرسال رمز التحقق لإعادة تعيين كلمة المرور',
                style: GoogleFonts.tajawal(color: grey4, fontSize: 15.sp),
              ),
              CustomTextField(
                  controller: TextEditingController(),
                  hint: 'البريد الإلكتروني'),
              SizedBox(height: 25.h),
              CustomButton(
                text: 'ارسال',
                onPressed: () {},
                backgroundColor: kprimaryColor,
                textColor: Colors.white,
                date: false,
              ),
            ],
          ),
        ),
      );
    },
  );
}

DateTime? _selectedDay = DateTime.now();

void showDatePickerDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.2),
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            title: Text(
              "حدد التاريخ",
              style: GoogleFonts.tajawal(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            content: SizedBox(
              width: 300,
              height: 400,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TableCalendar(
                      firstDay: DateTime(2025),
                      lastDay: DateTime(2030),
                      focusedDay: _selectedDay ?? DateTime.now(),
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                        leftChevronIcon: Image.asset(
                          'assets/icons/calender-arrow-left.png',
                          width: 20.w,
                        ),
                        rightChevronIcon: Image.asset(
                          'assets/icons/calendar-arrow-right.png',
                          width: 20.w,
                        ),
                        titleTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                      calendarStyle: CalendarStyle(
                        defaultTextStyle: TextStyle(color: Colors.black),
                        outsideTextStyle: TextStyle(color: Colors.grey),
                        todayDecoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.rectangle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: kprimaryColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "إلغاء",
                  style: GoogleFonts.tajawal(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(),
              CustomButton(
                text: 'متابعة',
                onPressed: () {},
                backgroundColor: kprimaryColor,
                textColor: Colors.white,
                date: true,
              ),
            ],
          ),
        ),
      );
    },
  );
}
