import 'dart:io';
import 'package:Levant_Sale/src/modules/more/ui/screens/delete-account/delete-account.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/widgets/add-photo-container.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/widgets/draggable-button.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/widgets/photo-section.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/constants.dart';
import '../../../../auth/ui/alerts/alert.dart';
import '../../../../auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import '../../../../auth/ui/screens/sign-up/widgets/phone-section.dart';
import '../../../../home/ui/screens/ads/widgets/title-row.dart';

class EditProfileScreen extends StatelessWidget {
  static const id = '/edit-profile';
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<EditProfileProvider>(context);
    final TextEditingController nameController =
        TextEditingController(text: 'منة الله');
    final TextEditingController emailController =
        TextEditingController(text: 'menna@gmail.com');
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController dateController = TextEditingController(
        text: DateFormat('MMMM dd, yyyy').format(DateTime.now()));
    final TextEditingController addressController =
        TextEditingController(text: 'حلب');
    final TextEditingController taxController =
        TextEditingController(text: '23456789');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        leading: SizedBox(),
        title: Center(
          child: TitleRow(
            title: 'تعديل منة الله',
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                ImageSection(),
                SizedBox(height: 5.h),
                UploadPhotoContainer(),
                SizedBox(height: 20.h),
                CustomTextField(
                  labelGrey: true,
                  controller: nameController,
                  label: 'الاسم',
                  bgcolor: grey8,
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  labelGrey: true,
                  controller: emailController,
                  label: 'البريد الإلكتروني',
                  keyboardType: TextInputType.emailAddress,
                  bgcolor: grey8,
                ),
                SizedBox(height: 16.h),
                PhoneSection(
                  controller: phoneController,
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  labelGrey: true,
                  prefix: GestureDetector(
                    onTap: () => showDatePickerDialog(context, dateController),
                    child: SvgPicture.asset(
                      calendarIcon,
                      height: 24.h,
                      width: 24.w,
                    ),
                  ),
                  controller: dateController,
                  label: profileProvider.isCompanyAccount
                      ? 'تاريخ إنشاء الشركة'
                      : 'تاريخ الميلاد',
                  bgcolor: grey8,
                ),
                if (profileProvider.isCompanyAccount) ...[
                  SizedBox(height: 16.h),
                  CustomTextField(
                    labelGrey: true,
                    controller: addressController,
                    label: 'عنوان الشركة',
                    bgcolor: grey8,
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    labelGrey: true,
                    controller: taxController,
                    label: 'الرقم الضريبي',
                    bgcolor: grey8,
                  ),
                ],
                SizedBox(height: 20.h),
                InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, DeleteAccountScreen.id),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        arrowLeftPath,
                        height: 15.h,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'حذف الحساب',
                        style: TextStyle(fontSize: 15.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: DraggableButton(
        'حفظ التعديلات',
        onPressed: () => editDoneAlert(context),
        icon: SvgPicture.asset(
          editWhiteIcon,
          height: 20.h,
        ),
      ),
    );
  }
}
