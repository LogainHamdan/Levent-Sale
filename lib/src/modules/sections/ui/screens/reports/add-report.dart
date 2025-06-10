import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/reports/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/reports/reports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../../../../auth/ui/alerts/alert.dart';
import '../../../../auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import '../../../../auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import '../../../../home/ui/screens/ads/widgets/title-row.dart';

class AddReportScreen extends StatelessWidget {
  final bool adReport;
  static const id = '/add-report';

  const AddReportScreen({super.key, required this.adReport});

  @override
  Widget build(BuildContext context) {
    final reportProvider = Provider.of<ReportProvider>(context, listen: false);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        title: TitleRow(title: 'انشاء ابلاغ'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.h),
          child: Column(
            children: [
              // CustomTextField(
              //     suffix: Icon(
              //       Icons.email_outlined,
              //       color: grey5,
              //     ),
              //     label: 'البريد الإلكتروني',
              //     controller: TextEditingController(),
              //     hint: 'menna@gmail.com',
              //     bgcolor: grey8),
              CustomTextField(
                controller: reportProvider.reasonController,
                label: 'السبب',
                bgcolor: grey8,
                paragraphBorderRadius: 2,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: reportProvider.descriptionController,
                label: 'الإبلاغ',
                bgcolor: grey8,
                paragraph: true,
                paragraphBorderRadius: 2.r,
              ),
              SizedBox(height: 10.h),
              CustomElevatedButton(
                text: 'ارسال',
                onPressed: () async {
                  final user = await UserHelper.getUser();
                  adReport
                      ? await reportProvider.addAdReport(
                          homeProvider.selectedAd?.id ?? 0,
                          reportProvider.reasonController.text,
                          reportProvider.descriptionController.text)
                      : await reportProvider.addUserReport(
                          user?.id ?? 0,
                          reportProvider.reasonController.text,
                          reportProvider.descriptionController.text);
                  if (reportProvider.isReportCreated) {
                    await showTicketCreated(context);
                    reportProvider.reasonController.clear();
                    reportProvider.descriptionController.clear();
                    await reportProvider.loadUserReports();
                    Navigator.pushReplacementNamed(context, ReportsScreen.id);
                  }
                },
                backgroundColor: kprimaryColor,
                textColor: grey9,
              )
            ],
          ),
        ),
      ),
    );
  }
}
