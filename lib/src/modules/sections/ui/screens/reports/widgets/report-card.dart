import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/ticket-conversation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../../../../models/report.dart';
import '../../../../models/reportDTO.dart';
import '../provider.dart';

class CustomReportCard extends StatelessWidget {
  final Report report;

  const CustomReportCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReportProvider>(context, listen: false);
    print('report passed: ${report.id}');
    return GestureDetector(
      onTap: () {
        provider.setSelectedReport(report);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: grey8,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                ReportTypeExtension.fromString(report.reportType ?? 'Ad')
                    .arabicName,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: kprimaryColor,
                ),
              ),
              Text(
                report.reason ?? '',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: grey0,
                ),
              ),
            ]),
            SizedBox(height: 16.h),
            Text(
              report.description ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: grey4,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('MMM dd, yyyy • hh:mm a')
                      .format(report.reportedAt ?? DateTime.now()),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: grey0,
                  ),
                ),
                Text(
                  ReportStatusExtension.fromString(report.status ?? 'PENDING')
                      .arabicName,
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: grey0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
