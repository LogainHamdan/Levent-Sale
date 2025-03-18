import 'dart:io';
import 'dart:ui';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/custom-rating.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../config/constants.dart';
import '../../../home/ui/screens/evaluation/widgets/img-picker.dart';
import '../screens/login/widgets/confrm-cancel-button.dart';
import '../screens/sign-up/widgets/custom-pass-field.dart';
import '../screens/sign-up/widgets/custom-text-field.dart';
import '../screens/splash/widgets/custom-elevated-button.dart';

void showPasswordUpdated(BuildContext context) {
  if (!context.mounted) return;

  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.2),
    builder: (dialogContext) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
          contentPadding: EdgeInsets.zero, // Removes default padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r), // Rounded corners
          ),
          content: SizedBox(
            width: 350.w,
            height: 360.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(dialogContext).pop(),
                      child: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Image.asset(
                          'assets/imgs_icons/auth/assets/icons/cancel.png',
                          height: 25.h, // Slightly larger cancel icon
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: Image.asset(
                    'assets/imgs_icons/auth/assets/imgs/tick.png',
                    height: 120.h, // Larger tick icon
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  'تم تحديث كلمة المرور',
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.tajawal(
                    color: kprimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 28.sp, // Slightly larger text
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'لقد تم تحديث كلمة المرور الخاصة بك',
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.tajawal(
                      color: grey4,
                      fontSize: 18.sp, // Increased font size
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: ConfirmCancelButton(
                    text: 'تسجيل دخول',
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    backgroundColor: kprimaryColor,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
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
                      'assets/imgs_icons/auth/assets/icons/cancel.png',
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
                  bgcolor: grey8,
                  controller: firstController,
                  hint: 'أدخل الرمز المرسل'),
              SizedBox(
                height: 8.h,
              ),
              CustomPasswordField(
                  controller: secondController, hint: 'كلمة المرور الجديدة'),
              SizedBox(
                height: 8.h,
              ),
              CustomPasswordField(
                  controller: thirdController,
                  hint: 'تأكيد كلمة المرور الجديدة'),
              SizedBox(
                height: 8.h,
              ),
              SizedBox(height: 25.h),
              ConfirmCancelButton(
                text: 'تأكيد',
                onPressed: () {},
                backgroundColor: kprimaryColor,
                textColor: Colors.white,
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
                      'assets/imgs_icons/auth/assets/icons/cancel.png',
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
                  bgcolor: grey8,
                  controller: TextEditingController(),
                  hint: 'البريد الإلكتروني'),
              SizedBox(height: 25.h),
              ConfirmCancelButton(
                text: 'ارسال',
                onPressed: () {},
                backgroundColor: kprimaryColor,
                textColor: Colors.white,
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
                          'assets/imgs_icons/general/arrow-left.png',
                          width: 20.w,
                        ),
                        rightChevronIcon: Image.asset(
                          'assets/imgs_icons/general/arrow-right.png',
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
              ConfirmCancelButton(
                text: 'متابعة',
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, HomeScreen.id),
                backgroundColor: kprimaryColor,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showRatingDialog(BuildContext context) {
  double rating = 4.0;
  TextEditingController commentController = TextEditingController();
  File? selectedImage;

  showDialog(
    context: context,
    barrierDismissible: true, // Allows dismissing the dialog by tapping outside
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return GestureDetector(
            onTap: () =>
                Navigator.pop(context), // Dismiss dialog on outside tap
            child: Dialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              child: Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        height: 3 * MediaQuery.of(context).size.height / 4,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("إضافة تقييم",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 20.h),
                            Text("تقييمك حول هذا الإعلان"),
                            SizedBox(height: 5.h),
                            CustomRating(rateNum: false, flexible: true),
                            SizedBox(height: 30.h),
                            CustomTextField(
                                bgcolor: Colors.white,
                                controller: commentController,
                                hint: 'اكتب تعليقك'),
                            SizedBox(height: 20.h),
                            Text("إضافة صورة"),
                            SizedBox(height: 10.h),
                            ImagePickerWidget(
                              icon: Container(
                                width: 100.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: Colors.green[100],
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child:
                                    const Icon(Icons.add, color: Colors.green),
                              ),
                            ),
                            SizedBox(height: 30.h),
                            ConfirmCancelButton(
                              text: 'نشر',
                              onPressed: () {},
                              backgroundColor: kprimaryColor,
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
