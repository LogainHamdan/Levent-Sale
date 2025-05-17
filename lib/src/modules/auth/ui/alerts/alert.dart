import 'dart:io';
import 'dart:ui';
import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/widgets/cancel-option.dart';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/widgets/custom-alert.dart';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/widgets/custom-divider.dart';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/widgets/custom-option.dart';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/widgets/empty-text-field.dart';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/widgets/option-tile.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/login.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/login/provider.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/logo/logo.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/splash.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/verify/verify.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ad-details/widgets/simple-title.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/custom-rating.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/home.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/widgets/change-pass-column.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/favorite/favorite.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/profile.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/ticket-conversation.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/my-collection.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../config/constants.dart';
import '../../../home/ui/screens/evaluation/widgets/img-picker.dart';
import '../../../main/ui/screens/main_screen.dart';
import '../../../main/ui/screens/provider.dart';
import '../../../more/models/tag.dart';
import '../../../more/ui/screens/edit-profile/provider.dart';
import '../../../more/ui/screens/edit-profile/widgets/title-cancel.dart';
import '../../../more/ui/screens/tech-support/technical-support.dart';
import '../../../sections/ui/screens/section-details/widgets/custom-dropdown.dart';
import '../screens/login/widgets/confrm-cancel-button.dart';
import '../screens/sign-up/widgets/custom-dropdowm.dart';
import '../screens/sign-up/widgets/custom-pass-field.dart';
import '../screens/sign-up/widgets/custom-text-field.dart';
import '../screens/splash/widgets/custom-elevated-button.dart';

void showPasswordUpdated(BuildContext context) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
          backgroundColor: grey9,
          contentPadding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          content: SizedBox(
            height: 300.h,
            width: 427.w,
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
                        child: SvgPicture.asset(
                          cancelPath,
                          height: 18.h,
                          width: 18.w,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: SvgPicture.asset(
                    tickPath,
                    height: 100.h,
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  'تم تحديث كلمة المرور',
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.tajawal(
                    color: kprimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'لقد تم تحديث كلمة المرور الخاصة بك',
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.tajawal(
                      color: grey3,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: CustomElevatedButton(
                        text: 'تسجيل دخول',
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          Navigator.pushNamed(dialogContext, LoginScreen.id);
                        },
                        backgroundColor: kprimaryColor,
                        textColor: greySplash)),
                SizedBox(height: 14.h),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showSetNewPassword(BuildContext context) {
  TextEditingController sentCodeController = TextEditingController();
  TextEditingController newPassAlertController = TextEditingController();
  TextEditingController confirmNewPassAlertController = TextEditingController();

  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.2),
    builder: (dialogContext) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)),
            backgroundColor: grey9,
            content: SizedBox(
              height: 355.h,
              child: ChangePassColumn(alert: true),
            )),
      );
    },
  );
}

void showForgotPassword(BuildContext context) {
  final authProvider = Provider.of<LoginProvider>(context, listen: false);
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.2),
    builder: (dialogContext) {
      return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.w, sigmaY: 10.h),
          child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r)),
              backgroundColor: grey9,
              content: SizedBox(
                width: 330.w,
                height: 250.h,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(dialogContext).pop(),
                          child: SvgPicture.asset(
                            cancelPath,
                            height: 18.h,
                            width: 18.w,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      'نسيت كلمة المرور',
                      style: GoogleFonts.tajawal(
                          color: kprimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      'أدخل البريد الإلكتروني الخاص بك وسنقوم بإرسال رمز التحقق لإعادة تعيين كلمة المرور',
                      style: GoogleFonts.tajawal(color: grey3, fontSize: 12.sp),
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                        bgcolor: grey8,
                        controller: authProvider.emailRequestController,
                        hint: 'البريد الإلكتروني'),
                    SizedBox(height: 24.h),
                    CustomElevatedButton(
                        text: 'ارسال',
                        onPressed: () async {
                          print(
                              'email: ${authProvider.emailRequestController.text}');
                          await authProvider.requestPasswordReset(
                            email: authProvider.emailRequestController.text,
                          );
                          if (authProvider.errorMessage == null) {
                            Navigator.pop(context);
                            showEmailSent(context);
                          } else {
                            print("Error: ${authProvider.errorMessage}");
                          }
                        },
                        backgroundColor: kprimaryColor,
                        textColor: greySplash),
                  ],
                ),
              )));
    },
  );
}

void showActivateAccount(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.2),
    builder: (dialogContext) {
      return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.w, sigmaY: 10.h),
          child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r)),
              backgroundColor: grey9,
              content: SizedBox(
                width: 330.w,
                height: 240.h,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(dialogContext).pop(),
                          child: SvgPicture.asset(
                            cancelPath,
                            height: 18.h,
                            width: 18.w,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      'قم بتفعيل حسابك',
                      style: GoogleFonts.tajawal(
                          color: kprimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      ' قمنا بإرسال رابط تفعيل على الإيميل الخاص بك، ان لم تجده في صندوق الوارد ابحث عنه في البريد العشوائي. بعد تفعيل الحساب قم بتسجيل الدخول',
                      style: GoogleFonts.tajawal(color: grey3, fontSize: 14.sp),
                    ),
                    SizedBox(height: 24.h),
                    CustomElevatedButton(
                        text: 'تسجيل الدخول',
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        backgroundColor: kprimaryColor,
                        textColor: greySplash),
                  ],
                ),
              )));
    },
  );
}

void showEmailSent(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.2),
    builder: (dialogContext) {
      return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.w, sigmaY: 10.h),
          child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r)),
              backgroundColor: grey9,
              content: SizedBox(
                width: 330.w,
                height: 240.h,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(dialogContext).pop(),
                          child: SvgPicture.asset(
                            cancelPath,
                            height: 18.h,
                            width: 18.w,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      "تم إرسال رابط تعيين كلمة المرور",
                      style: GoogleFonts.tajawal(
                          color: kprimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      ' قمنا بإرسال رابط لتعيين كلمة المرور على الإيميل الخاص بك، ان لم تجده في صندوق الوارد ابحث عنه في البريد العشوائي. بعد تعيين كلمة المرور قم بتسجيل الدخول',
                      style: GoogleFonts.tajawal(color: grey3, fontSize: 14.sp),
                    ),
                    SizedBox(height: 24.h),
                    CustomElevatedButton(
                        text: 'تسجيل الدخول',
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        backgroundColor: kprimaryColor,
                        textColor: greySplash),
                  ],
                ),
              )));
    },
  );
}

DateTime _selectedDay = DateTime.now();

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
            backgroundColor: grey9,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            title: Text(
              "حدد التاريخ",
              style: GoogleFonts.tajawal(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TableCalendar(
                      firstDay: DateTime(1900),
                      lastDay: DateTime(2026),
                      focusedDay: _selectedDay,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                        formatButtonVisible: false,
                        leftChevronIcon: SvgPicture.asset(
                          calendarArrowLeftPath,
                          width: 20.w,
                        ),
                        rightChevronIcon: SvgPicture.asset(
                          calendarArrowRightPath,
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
                        ),
                        selectedDecoration: BoxDecoration(
                          color: kprimaryColor,
                          shape: BoxShape.circle,
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
                date: true,
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
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        height: 2.2 * MediaQuery.of(context).size.height / 4,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.r),
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
                            SizedBox(height: 20.h),
                            CustomTextField(
                                bgcolor: grey8,
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
                                  color: Color(0xFFE6F1D2),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: kprimaryColor,
                                  size: 12.h,
                                ),
                              ),
                            ),
                            SizedBox(height: 25.h),
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
  final bottomNavProvider =
      Provider.of<BottomNavProvider>(context, listen: false);
  final createAdProvider =
      Provider.of<CreateAdProvider>(context, listen: false);

  if (!context.mounted) return;

  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.2),
    builder: (dialogContext) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.w, sigmaY: 10.h),
        child: AlertDialog(
          backgroundColor: grey9,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          content: SizedBox(
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
                      },
                      child: Padding(
                        padding: EdgeInsets.all(20.w),
                        child: SvgPicture.asset(
                          cancelPath,
                          height: 18.h,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: SvgPicture.asset(
                    adCreatedIcon,
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
                    fontSize: 24.sp,
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
                      color: grey3,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: CustomElevatedButton(
                      text: 'عرض تشكيلتي',
                      onPressed: () {
                        bottomNavProvider.setIndex(1);
                        createAdProvider.resetProgress();
                        Navigator.pushNamed(context, MainScreen.id);
                      },
                      backgroundColor: kprimaryColor,
                      textColor: grey9,
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

void showTicketCreated(BuildContext context) {
  if (!context.mounted) return;

  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.2),
    builder: (dialogContext) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.w, sigmaY: 10.h),
        child: AlertDialog(
          backgroundColor: grey9,
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          content: SizedBox(
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
                      },
                      child: Padding(
                        padding: EdgeInsets.all(20.w),
                        child: SvgPicture.asset(
                          cancelPath,
                          height: 18.h,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: SvgPicture.asset(
                    adCreatedIcon,
                    height: 120.h,
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  'تم ارسال الرسالة',
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.tajawal(
                    color: kprimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    maxLines: 2,
                    'تم ارسالة رسالتك للجهة المختصة ويمكنك مراجعة التطورات خلال صفحة الدعم الفني مع جميع رسائلك',
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.tajawal(
                      color: grey3,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                  child: CustomElevatedButton(
                      text: 'جميع الرسائل',
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, TechnicalSupportScreen.id),
                      backgroundColor: kprimaryColor,
                      textColor: grey9),
                )
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
        backgroundColor: grey9,
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

Future<void> showAddToFavoriteAlert(
    BuildContext context, dynamic adId, String tagId) async {
  final token = await TokenHelper.getToken();
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext sheetContext) {
      final favoriteProvider =
          Provider.of<FavoriteProvider>(sheetContext, listen: false);
      return GestureDetector(
        onTap: () => Navigator.pop(sheetContext),
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.white.withOpacity(0.2)),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15.r)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "احفظ في قائمة المفضلة",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(sheetContext).pop(),
                          child: Padding(
                            padding: EdgeInsets.all(10.w),
                            child: SvgPicture.asset(
                              cancelPath,
                              height: 18.h,
                              width: 18.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    FutureBuilder(
                      future: favoriteProvider.fetchTags(token ?? ''),
                      builder: (context, snapshot) {
                        final provider = Provider.of<FavoriteProvider>(context);
                        final tagNames =
                            provider.tags.map((e) => e.name).toList();

                        return CustomDropdownSection(
                          hint: "اختر التشكيلة",
                          items: tagNames,
                          dropdownKey: "tagDropdown",
                          onItemSelected: (selectedItem) {
                            final tag = favoriteProvider.tags
                                .firstWhere((tag) => tag.name == selectedItem);
                            favoriteProvider.setSelectedTag(tag);
                          },
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    CustomElevatedButton(
                      backgroundColor: kprimaryColor,
                      text: 'اضافة الى المفضلة',
                      textColor: grey9,
                      onPressed: () async {
                        try {
                          final token = await TokenHelper.getToken();
                          final success = await favoriteProvider.addToTag(
                            context,
                            adId: adId,
                            authorizationToken: token ?? '',
                            tagId: favoriteProvider.selectedTag!.id ?? '',
                          );

                          Navigator.pop(sheetContext);

                          if (context.mounted) {
                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('تمت الإضافة إلى المفضلة بنجاح',
                                      textDirection: TextDirection.rtl),
                                  backgroundColor: kprimaryColor,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'الإعلان موجود بالمفضلة بالفعل',
                                    textDirection: TextDirection.rtl,
                                  ),
                                  backgroundColor: errorColor,
                                ),
                              );
                            }
                          }
                        } on DioException catch (e) {
                          Navigator.pop(sheetContext);
                          if (e.response?.statusCode == 409) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('الإعلان موجود بالمفضلة بالفعل'),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('حدث خطأ غير متوقع، حاول مرة أخرى'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () => showNewCollectionAlert(
                          context, favoriteProvider.tagController),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'تشكيلة جديدة',
                            style: TextStyle(
                                color: kprimaryColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(width: 4.w),
                          SvgPicture.asset(addCircleGreenIcon,
                              height: 20.h, width: 20.w),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

void showNewCollectionAlert(
    BuildContext context, TextEditingController newTagController) {
  final provider = Provider.of<FavoriteProvider>(context, listen: false);

  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.2),
    builder: (context) {
      return GestureDetector(
        onTap: () => Navigator.pop(context),
        behavior: HitTestBehavior.opaque,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.w, sigmaY: 10.h),
          child: Dialog(
            backgroundColor: grey9,
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
                    EmptyTextField(controller: provider.tagController),
                    SizedBox(height: 20.h),
                    CustomElevatedButton(
                      text: 'حفظ',
                      onPressed: () async {
                        final token = await TokenHelper.getToken();

                        final provider = Provider.of<FavoriteProvider>(context,
                            listen: false);
                        String tagName = newTagController.text.trim();

                        if (tagName.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'يرجى إدخال اسم التشكيلة!',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        await provider.createTag(tagName, token ?? '');

                        await provider.fetchTags(token ?? '');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'تم انشاء التشكيلة بنجاح!',
                            ),
                            backgroundColor: kprimaryColor,
                          ),
                        );
                        Navigator.pop(context);
                      },
                      backgroundColor: kprimaryColor,
                      textColor: grey9,
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

void editDoneAlert(BuildContext context) async {
  showCustomAlertDialog(
    context: context,
    title: 'تم التعديل',
    message: 'هل أنت متأكد من التعديلات؟',
    confirmText: 'تعديل',
    confirmColor: infoColor,
    onConfirm: () async {
      try {
        final profileProvider =
            Provider.of<EditProfileProvider>(context, listen: false);
        final token = await TokenHelper.getToken();

        if (token == null || token.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'حدث خطأ: لم يتم العثور على التوكن',
                textDirection: TextDirection.rtl,
              ),
              backgroundColor: errorColor,
            ),
          );
          return;
        }
        await profileProvider.updateProfile(
          token: token,
          firstName: profileProvider.firstNameController.text,
          lastName: profileProvider.lastNameController.text,
          birthday: profileProvider.dateController.text,
          profilePicture: profileProvider.profileImage,
          businessLicense: profileProvider.businessLicenseController.text,
          fullAddress: profileProvider.addressController.text,
        );

        Navigator.pop(context);
        Navigator.pushNamed(context, ProfileScreen.id);
      } catch (e, stack) {
        print("Error during profile update: $e");
        print("Stack trace: $stack");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ أثناء التحديث: $e')),
        );
      }
    },
  );
}

void deleteAccountAlert(BuildContext context) {
  showCustomAlertDialog(
      context: context,
      title: 'هل أنت متأكد؟',
      message: 'هل أنت متأكد من حذف حسابك',
      confirmText: 'حذف الحساب',
      confirmColor: errorColor,
      cancelColor: Colors.black,
      onConfirm: () {
        Navigator.pushNamed(context, SplashScreen.id);
      });
}

void deleteCollectionAlert(BuildContext context, String tagId) {
  showCustomAlertDialog(
      context: context,
      title: 'هل أنت متأكد؟',
      message: 'هل أنت متأكد من حذف التشكيلة',
      confirmText: 'حذف',
      confirmColor: errorColor,
      cancelColor: Colors.black,
      onConfirm: () async {
        final token = await TokenHelper.getToken();
        if (token == null || token.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("سجل دخول اولاً")),
          );
          return;
        }

        final favoriteProvider =
            Provider.of<FavoriteProvider>(context, listen: false);
        Navigator.pop(context);
        await favoriteProvider.deleteFavoriteTag(
            tagId: tagId, authorizationToken: token ?? '');

        Navigator.pushNamed(context, FavoriteScreen.id);
      });
}

void logoutAlert(
  BuildContext context,
) {
  showCustomAlertDialog(
      context: context,
      title: 'هل أنت متأكد؟',
      message: 'هل أنت متأكد من تسجيل الخروج؟',
      confirmText: 'تسجيل خروج',
      confirmColor: errorColor,
      cancelColor: Colors.black,
      onConfirm: () async {
        final provider = Provider.of<LoginProvider>(context, listen: false);
        final rememberUser = await UserHelper.getRememberedUser();
        await TokenHelper.removeToken();
        await UserHelper.removeUser();
        if (rememberUser == null) {
          await UserHelper.removeRememberMeStatus();
          provider.emailController.clear();
          provider.passwordController.clear();
        }

        print('remembered user after logout: $rememberUser');
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('تم تسجيل الخروج بنجاح', textDirection: TextDirection.rtl),
            backgroundColor: errorColor,
          ),
        );
        Navigator.pushReplacementNamed(context, LogoScreen.id);
      });
}

void changePictureOptionAlert(
    BuildContext context, Function(File?) onImageSelected) {
  final editProfileProvider =
      Provider.of<EditProfileProvider>(context, listen: false);

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
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
            ),
            Center(
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                backgroundColor: grey9,
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
                        icon: SvgPicture.asset(
                          takePhotoIcon,
                          height: 20.h,
                        ),
                        onTap: () => editProfileProvider.pickImage(
                            context, ImageSource.camera,
                            isProfile: true),
                      ),
                      CustomDivider(),
                      OptionTile(
                        color: grey4,
                        title: "اختر من الاستديو",
                        icon: SvgPicture.asset(
                          fromGalleryIcon,
                          height: 20.h,
                        ),
                        onTap: () => editProfileProvider.pickImage(
                            context, ImageSource.gallery,
                            isProfile: true),
                      ),
                      CustomDivider(),
                      OptionTile(
                        color: errorColor,
                        title: "حذف الصورة",
                        icon: SvgPicture.asset(
                          deleteCollectionIcon,
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
