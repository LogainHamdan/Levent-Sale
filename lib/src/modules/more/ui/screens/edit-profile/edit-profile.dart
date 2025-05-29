import 'package:Levant_Sale/src/modules/auth/models/user.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/delete-account/delete-account.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/widgets/add-photo-container.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/widgets/draggable-button.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/edit-profile/widgets/photo-section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/constants.dart';
import '../../../../auth/repos/token-helper.dart';
import '../../../../auth/repos/user-helper.dart';
import '../../../../auth/ui/alerts/alert.dart';
import '../../../../auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import '../../../../auth/ui/screens/sign-up/widgets/phone-section.dart';
import '../../../../home/ui/screens/ads/widgets/title-row.dart';

class EditProfileScreen extends StatefulWidget {
  static const id = '/edit-profile';

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<EditProfileProvider>(context, listen: false);
      if (!provider.isInit) {
        provider.init();
        provider.isInit = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProfileProvider>(
        builder: (context, profileProvider, child) => Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.white,
                  titleTextStyle: Theme.of(context).textTheme.bodyLarge,
                  leading: SizedBox(),
                  title: TitleRow(
                    title: '${profileProvider.firstNameController.text} تعديل',
                  )),
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        FutureBuilder(
                            future: UserHelper.getUser(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CustomCircularProgressIndicator();
                              }
                              return ImageSection(
                                profileImg: snapshot.data?.profilePicture ?? '',
                              );
                            }),
                        // SizedBox(height: 20.h),
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: Text(
                        //     textDirection: TextDirection.rtl,
                        //     'صورة غلاف الملف الشخصي',
                        //     style: TextStyle(
                        //       color: grey5,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 5.h),
                        //   UploadPhotoContainer(),
                        // SizedBox(height: 20.h),
                        if (!profileProvider.isCompanyAccount) ...[
                          SizedBox(height: 16.h),
                          CustomTextField(
                            labelGrey: true,
                            controller: profileProvider.firstNameController,
                            label: 'الاسم الأول',
                            bgcolor: grey8,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          CustomTextField(
                            labelGrey: true,
                            controller: profileProvider.lastNameController,
                            label: 'الكنية',
                            bgcolor: grey8,
                          ),
                        ],
                        SizedBox(
                          height: 16.h,
                        ),
                        CustomTextField(
                          labelGrey: true,
                          prefix: GestureDetector(
                            onTap: () => showDatePickerDialog(
                                context, profileProvider.dateController),
                            child: SvgPicture.asset(
                              calendarIcon,
                              height: 20.h,
                              width: 20.w,
                            ),
                          ),
                          controller: profileProvider.dateController,
                          label: profileProvider.isCompanyAccount
                              ? 'تاريخ إنشاء الشركة'
                              : 'تاريخ الميلاد',
                          bgcolor: grey8,
                        ),
                        if (profileProvider.isCompanyAccount) ...[
                          SizedBox(height: 16.h),
                          CustomTextField(
                            labelGrey: true,
                            controller: profileProvider.businessNameController,
                            label: 'اسم الشركة',
                            bgcolor: grey8,
                          ),
                          SizedBox(height: 16.h),
                          CustomTextField(
                            labelGrey: true,
                            controller:
                                profileProvider.businessLicenseController,
                            label: 'الرقم الضريبي',
                            bgcolor: grey8,
                          ),
                        ],
                        CustomTextField(
                          labelGrey: true,
                          controller: profileProvider.addressController,
                          label: 'العنوان',
                          bgcolor: grey8,
                        ),
                        SizedBox(height: 20.h),
                        InkWell(
                          onTap: () => Navigator.pushNamed(
                              context, DeleteAccountScreen.id),
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
                onPressed: () async {
                  editDoneAlert(context);
                },
                icon: SvgPicture.asset(
                  editWhiteIcon,
                  height: 20.h,
                ),
              ),
            ));
  }
}
