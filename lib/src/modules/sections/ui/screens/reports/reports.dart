import 'package:Levant_Sale/src/modules/sections/ui/screens/reports/provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/reports/widgets/report-card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../../../../auth/repos/token-helper.dart';
import '../../../../home/ui/screens/ads/widgets/title-row.dart';
import '../../../../home/ui/screens/chats/no-info-widget.dart';
import '../../../../home/ui/screens/home/widgets/custom-indicator.dart';

class ReportsScreen extends StatefulWidget {
  static const id = '/reports';

  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  late Future<void> reportsFuture;

  @override
  void initState() {
    super.initState();
    reportsFuture = _fetchReports();
  }

  Future<void> _fetchReports() async {
    try {
      final provider = Provider.of<ReportProvider>(context, listen: false);
      await provider.loadUserReports();
    } catch (e) {
      print("Error fetching reports: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        leading: SizedBox(),
        title: TitleRow(
          title: 'إبلاغاتي',
        ),
      ),
      body: SafeArea(
        child: Consumer<ReportProvider>(
          builder: (context, provider, child) => Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0.w,
                vertical: 16.0.h,
              ),
              child: FutureBuilder<void>(
                future: reportsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CustomCircularProgressIndicator());
                  }

                  final reports = provider.reports;
                  return Column(
                    children: [
                      reports.isEmpty
                          ? NoInfoWidget(
                              img: emptyChatIcon, msg: 'لا يوجد لديك ابلاغات')
                          : Expanded(
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 10.h),
                                itemCount: reports.length,
                                itemBuilder: (context, index) {
                                  print(reports.length);
                                  final report = reports[index];
                                  print('ticket: ${report.toJson()}');
                                  print('ticket id: ${report.id}');
                                  return CustomReportCard(
                                    report: report,
                                  );
                                },
                              ),
                            ),
                      SizedBox(
                        height: 24.h,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
