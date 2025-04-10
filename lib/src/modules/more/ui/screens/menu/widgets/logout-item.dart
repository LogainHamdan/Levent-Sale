import 'package:Levant_Sale/src/modules/auth/ui/screens/login/repos/logout-repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../config/constants.dart';
import '../../../../../auth/ui/alerts/alert.dart';
import '../../../../../auth/ui/alerts/widgets/custom-alert.dart';
import '../../../../../auth/ui/screens/login/provider.dart';

class CustomLogoutItem extends StatelessWidget {
  const CustomLogoutItem({super.key});

  Future<void> _handleLogout(
      BuildContext context, AuthProvider authProvider) async {
    bool confirm = false;

    await showCustomAlertDialog(
      context: context,
      title: 'تأكيد تسجيل الخروج',
      message: 'هل أنت متأكد أنك تريد تسجيل الخروج؟',
      confirmText: 'نعم',
      confirmColor: errorColor,
      cancelColor: Colors.black,
      onConfirm: () {
        confirm = true;
      },
    );

    if (!confirm) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null) {
        await authProvider.logoutUser(context);
        if (context.mounted) {
          Navigator.pop(context);
          logoutAlert(context);
        }
      } else {
        if (context.mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('لا يوجد جلسة تسجيل دخول حالياً'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(authProvider.errorMessage ?? 'حدث خطأ أثناء تسجيل الخروج'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return InkWell(
          onTap: () => _handleLogout(context, authProvider),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5.h),
            decoration: BoxDecoration(
              color: grey8,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: ListTile(
              trailing: SvgPicture.asset(
                logoutIcon,
                height: 22.h,
              ),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'تسجيل الخروج',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.tajawal(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
              ),
              leading: Icon(Icons.arrow_back_ios_new,
                  size: 18.sp, color: Colors.black45),
            ),
          ),
        );
      },
    );
  }
}
