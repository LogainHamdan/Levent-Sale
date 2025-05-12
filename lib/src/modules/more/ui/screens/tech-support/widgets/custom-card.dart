import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../../config/constants.dart';
import '../../../../models/ticket.dart';

class CustomTicketCard extends StatelessWidget {
  final String title;
  final DateTime sentAt;
  final TicketStatus status;

  const CustomTicketCard({
    Key? key,
    required this.title,
    required this.sentAt,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: grey8,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'title',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: grey0,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('MMM dd, yyyy • hh:mm a').format(sentAt),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                  color: grey0,
                ),
              ),
              Text(
                status.name.toUpperCase(),
                style: TextStyle(
                    fontSize: 12.sp, fontWeight: FontWeight.w600, color: grey0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
