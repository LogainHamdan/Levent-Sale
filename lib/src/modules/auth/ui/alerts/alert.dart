import 'dart:io';
import 'dart:ui';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/widgets/cancel-option.dart';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/widgets/custom-alert.dart';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/widgets/custom-divider.dart';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/widgets/custom-option.dart';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/widgets/empty-text-field.dart';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/widgets/option-tile.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/widgets/simple-title.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/custom-rating.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/home.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/change-password/change-pass-column.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/favorite.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/my-collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../config/constants.dart';
import '../../../home/ui/screens/evaluation/widgets/img-picker.dart';

import '../../../main/ui/screens/main_screen.dart';
import '../../../more/ui/screens/edit-profile/widgets/title-cancel.dart';
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
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
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
                          height: 25.h,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: Image.asset(
                    'assets/imgs_icons/auth/assets/imgs/tick.png',
                    height: 120.h,
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  'تم تحديث كلمة المرور',
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.tajawal(
                    color: kprimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 28.sp,
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
                      fontSize: 18.sp,
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
            content: ChangePassColumn(
                firstController: firstController,
                secondController: secondController,
                thirdController: thirdController,
                alert: true)),
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
                onPressed: () => showSetNewPassword(context),
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

void showDatePickerDialog(
    BuildContext context, TextEditingController dateController) {
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

                        dateController.text =
                            "${selectedDay.toLocal()}".split(' ')[0];
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ConfirmCancelButton(
                text: 'متابعة',
                onPressed: () {
                  Navigator.pop(context);
                },
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
    barrierDismissible: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return GestureDetector(
            onTap: () => Navigator.pop(context),
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
                                  color: kprimaryColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Icon(Icons.add, color: kprimaryColor),
                              ),
                            ),
                            SizedBox(height: 30.h),
                            ConfirmCancelButton(
                              text: 'نشر',
                              onPressed: () => Navigator.pop(context),
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

void showAdCreated(BuildContext context) {
  if (!context.mounted) return;

  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.2),
    builder: (dialogContext) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.w, sigmaY: 10.h),
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
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
                      onTap: () {
                        Navigator.of(dialogContext).pop();
                        Navigator.pushReplacementNamed(context, MainScreen.id);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Image.asset(
                          'assets/imgs_icons/auth/assets/icons/cancel.png',
                          height: 25.h,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: Image.asset(
                    'assets/imgs_icons/sections/assets/imgs/تم انشاء اعلانك.png',
                    height: 120.h,
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  'تم إنشاء إعلانك',
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.tajawal(
                    color: kprimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 28.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    maxLines: 2,
                    'تم إنشاء إعلانك وسوف تتم مراجعته فالدهم الفني ونشره فاقرب وقت',
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.tajawal(
                      color: grey4,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: CustomElevatedButton(
                      text: 'عرض تشكيلتي',
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, MyCollectionScreen.id),
                      backgroundColor: kprimaryColor,
                      textColor: Colors.white,
                      date: false,
                    )),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void _showLocationPermissionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text(
          'الوصول الى الموقع',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomOption(text: 'عند استخدام التطبيق'),
            CustomDivider(),
            CustomOption(text: 'هذه المرة فقط'),
            CustomDivider(),
            CancelOption(text: 'إلغاء'),
          ],
        ),
      );
    },
  );
}

void showAddToFavoriteAlert(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    builder: (context) {
      return GestureDetector(
        onTap: () => Navigator.pop(context),
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.w, sigmaY: 10.h),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15.r)),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTitleCancel(title: "احفظ في قائمة المفضلة"),
                        SizedBox(height: 20.h),
                        Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: grey6,
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                          child: Center(child: Text("مفضلتي")),
                        ),
                        SizedBox(height: 10.h),
                        SimpleTitle(title: 'تشكيلة جديدة'),
                        EmptyTextField(
                          controller: TextEditingController(),
                        ),
                        SizedBox(height: 20.h),
                        CustomElevatedButton(
                          text: 'حفظ',
                          onPressed: () => showNewCollectionAlert(context),
                          backgroundColor: kprimaryColor,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showNewCollectionAlert(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    barrierDismissible: true,
    builder: (context) {
      return GestureDetector(
        onTap: () => Navigator.pop(context),
        behavior: HitTestBehavior.opaque,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.w, sigmaY: 10.h),
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r)),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTitleCancel(title: "تشكيلة جديدة"),
                    SizedBox(height: 20.h),
                    EmptyTextField(controller: TextEditingController()),
                    SizedBox(height: 20.h),
                    CustomElevatedButton(
                      text: 'حفظ',
                      onPressed: () {
                        Navigator.pop(context);
                        showAddToFavoriteAlert(context);
                      },
                      backgroundColor: kprimaryColor,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

void editDoneAlert(BuildContext context) {
  showCustomAlertDialog(
      context: context,
      title: 'تم التعديل',
      message: 'هل أنت متأكد من التعديلات؟',
      confirmText: 'تعديل',
      confirmColor: Colors.blue,
      onConfirm: () {});
}

void deleteAccountAlert(BuildContext context) {
  showCustomAlertDialog(
      context: context,
      title: 'هل أنت متأكد؟',
      message: 'هل أنت متأكد من حذف حسابك',
      confirmText: 'حذف الحساب',
      confirmColor: Colors.red,
      cancelColor: Colors.black,
      onConfirm: () {});
}

void deleteCollectionAlert(BuildContext context) {
  showCustomAlertDialog(
      context: context,
      title: 'هل أنت متأكد؟',
      message: 'هل أنت متأكد من حذف التشكيلة',
      confirmText: 'حذف',
      confirmColor: Colors.red,
      cancelColor: Colors.black,
      onConfirm: () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, FavoriteScreen.id);
      });
}

void logoutAlert(BuildContext context) {
  showCustomAlertDialog(
      context: context,
      title: 'هل أنت متأكد؟',
      message: 'هل أنت متأكد من تسجيل الخروج؟',
      confirmText: 'تسجيل خروج',
      confirmColor: Colors.red,
      cancelColor: Colors.black,
      onConfirm: () {});
}

void changePictureOptionAlert(
    BuildContext context, Function(File?) onImageSelected) {
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      onImageSelected(File(pickedFile.path));
    }
    Navigator.of(context).pop();
  }

  void deleteImage() {
    onImageSelected(null);
    Navigator.of(context).pop();
  }

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.w, sigmaY: 10.h),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
            Center(
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                backgroundColor: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 12.h, right: 20.w),
                        child: SimpleTitle(title: 'تغيير الصورة'),
                      ),
                      CustomDivider(),
                      OptionTile(
                        color: grey0,
                        title: "اخذ صورة",
                        icon: Image.asset(
                          'assets/imgs_icons/more/assets/icons/اخذ صورة.png',
                          height: 20.h,
                        ),
                        onTap: () => pickImage(ImageSource.camera),
                      ),
                      CustomDivider(),
                      OptionTile(
                        color: grey4,
                        title: "اختر من الاستديو",
                        icon: Image.asset(
                          'assets/imgs_icons/more/assets/icons/اختر من الاستديو.png',
                          height: 20.h,
                        ),
                        onTap: () => pickImage(ImageSource.gallery),
                      ),
                      CustomDivider(),
                      OptionTile(
                        color: Colors.red,
                        title: "حذف الصورة",
                        icon: Image.asset(
                          'assets/imgs_icons/more/assets/icons/حذف الصورة.png',
                          height: 20.h,
                        ),
                        onTap: deleteImage,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
