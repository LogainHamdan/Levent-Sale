import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/ticket-conversation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../../../../models/ticket.dart';
import '../provider.dart';

class CustomTicketCard extends StatelessWidget {
  final Ticket ticket;

  const CustomTicketCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TechSupportProvider>(context, listen: false);
    print('ticket passed: ${ticket.id}');
    return GestureDetector(
      onTap: () {
        provider.setSelectedTicket(ticket);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TicketConversationScreen(ticketId: ticket.id)));
      },
      child: Container(
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
              ticket.title,
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
                  DateFormat('MMM dd, yyyy • hh:mm a').format(ticket.createdAt),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: grey0,
                  ),
                ),
                Text(
                  ticket.status.name.toUpperCase(),
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
