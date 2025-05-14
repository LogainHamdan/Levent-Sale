import 'package:Levant_Sale/src/modules/auth/repos/token-helper.dart';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/alert.dart';
import 'package:Levant_Sale/src/modules/more/models/ticket-msgDTO.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/menu.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../../../../auth/ui/screens/sign-up/widgets/custom-text-field.dart';
import '../../../../auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import '../../../../home/ui/screens/ads/widgets/title-row.dart';
import '../../../../main/ui/screens/main_screen.dart';
import '../../../../main/ui/screens/provider.dart';

class SupportScreen extends StatelessWidget {
  static const id = '/support';
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);
    final techSupportProvider = Provider.of<TechSupportProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        title: TitleRow(title: 'انشاء تيكت'),
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
                controller: techSupportProvider.titleController,
                label: 'العنوان',
                bgcolor: grey8,
                paragraphBorderRadius: 2,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: techSupportProvider.msgController,
                label: 'الرسالة',
                bgcolor: grey8,
                paragraph: true,
                paragraphBorderRadius: 2.r,
              ),
              SizedBox(height: 10.h),
              CustomElevatedButton(
                text: 'ارسال',
                onPressed: () async {
                  final token = await TokenHelper.getToken();
                  final ticketMsg = TicketMessageDTO(
                      title: techSupportProvider.titleController.text,
                      message: techSupportProvider.msgController.text);
                  bottomNavProvider.setIndex(0);
                  await techSupportProvider.addTicket(
                      token: token ?? '', ticket: ticketMsg);
                  if (techSupportProvider.isTicketCreated) {
                    showTicketCreated(context);
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
