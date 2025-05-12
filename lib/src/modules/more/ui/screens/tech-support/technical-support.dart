import 'package:Levant_Sale/src/modules/home/ui/screens/ads/widgets/title-row.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/menu.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/tech-support-screen.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/tickets-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import 'faq-screen.dart';

class TechnicalSupportScreen extends StatelessWidget {
  static const id = '/tech';

  const TechnicalSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: SizedBox(),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: TitleRow(title: 'الدعم الفني'),
                ),
                SizedBox(
                  height: 16.h,
                ),
                TabBar(
                  indicatorColor: kprimaryColor,
                  unselectedLabelColor: grey5,
                  unselectedLabelStyle: GoogleFonts.tajawal(
                      textStyle: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w600)),
                  labelColor: kprimaryColor,
                  labelStyle: GoogleFonts.tajawal(
                      textStyle: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w600)),
                  tabs: [
                    Tab(
                      text: "الأسئلة الشائعة",
                    ),
                    Tab(text: "الدعم الفني"),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            FAQScreen(),
            TicketsScreen(),
          ],
        ),
      ),
    );
  }
}
