import 'dart:io';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/widgets/draggable-button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'dart:io';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../../../../auth/ui/alerts/alert.dart';
import '../../../../auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import '../../../../auth/ui/screens/sign-up/widgets/phone-section.dart';
import '../../../../home/ui/screens/ad-details/widgets/cutom-druggable-scrollable-sheet.dart';

class ProfileScreen extends StatelessWidget {
  static const id = '/profile';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => profileProvider.pickImage(false),
              child: Container(
                height: 150.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: grey8,
                  image: profileProvider.coverImage != null
                      ? DecorationImage(
                          image: FileImage(
                            File(profileProvider.coverImage!),
                          ),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: profileProvider.coverImage == null
                    ? Icon(Icons.add_a_photo, size: 50.sp)
                    : null,
              ),
            ),
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: () => profileProvider.pickImage(true),
              child: CircleAvatar(
                radius: 50.r,
                backgroundColor: Colors.grey[300],
                backgroundImage: profileProvider.profileImage != null
                    ? FileImage(File(profileProvider.profileImage!))
                    : null,
                child: profileProvider.profileImage == null
                    ? Icon(Icons.person, size: 50.sp)
                    : null,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (profileProvider.profileImage != null)
                  ElevatedButton(
                    onPressed: () => profileProvider.removeImage(true),
                    child: Text('إزالة الصورة الشخصية'),
                  ),
                SizedBox(width: 10),
                if (profileProvider.coverImage != null)
                  ElevatedButton(
                    onPressed: () => profileProvider.removeImage(false),
                    child: Text('إزالة صورة الغلاف'),
                  ),
              ],
            ),
            SizedBox(height: 20),
            CustomTextField(
              controller: nameController,
              label: 'الاسم',
              bgcolor: grey8,
            ),
            CustomTextField(
              controller: emailController,
              label: 'البريد الإلكتروني',
              keyboardType: TextInputType.emailAddress,
              bgcolor: grey8,
            ),
            SizedBox(height: 20.h),
            PhoneSection(),
            SizedBox(height: 20.h),
            CustomTextField(
              prefix: GestureDetector(
                onTap: () => showDatePickerDialog(context, dateController),
                child: Icon(Icons.calendar_month_outlined, color: grey0),
              ),
              controller: dateController,
              label: profileProvider.isCompanyAccount
                  ? 'تاريخ إنشاء الشركة'
                  : 'تاريخ الميلاد',
              bgcolor: grey8,
            ),
            profileProvider.isCompanyAccount
                ? CustomTextField(
                    controller: addressController,
                    label: 'عنوان الشركة',
                    bgcolor: grey8,
                  )
                : SizedBox(),
            profileProvider.isCompanyAccount
                ? CustomTextField(
                    controller: taxController,
                    label: 'الرقم الضريبي',
                    bgcolor: grey8,
                  )
                : SizedBox(),
            SizedBox(
              height: 10.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/imgs_icons/general/arrow-left.png',
                  height: 15.h,
                ),
                SizedBox(
                  width: 16.w,
                ),
                Text(
                  'حذف الحساب',
                  style: TextStyle(fontSize: 15.sp),
                ),
              ],
            ),
            Expanded(
              child: DraggableButton('حفظ التعديلات',
                  onPressed: () {}, icon: Image.asset('')),
            )
          ],
        ),
      ),
    );
  }
}
