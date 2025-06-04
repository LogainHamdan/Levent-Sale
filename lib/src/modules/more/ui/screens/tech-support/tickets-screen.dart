import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/ui/alerts/alert.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/chats/no-info-widget.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/tech-support-screen.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/technical-support.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/widgets/custom-card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../auth/repos/token-helper.dart';
import '../../../../auth/repos/user-helper.dart';
import '../../../models/ticket.dart';

class TicketsScreen extends StatefulWidget {
  static const id = '/tickets';

  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  late Future<void> ticketsFuture;

  @override
  void initState() {
    super.initState();
    ticketsFuture = _fetchTickets();
  }

  Future<void> _fetchTickets() async {
    try {
      final token = await TokenHelper.getToken();
      final user = await UserHelper.getUser();
      final provider = Provider.of<TechSupportProvider>(context, listen: false);

      await provider.getTickets(token: token ?? '', userId: user?.id ?? 0);
    } catch (e) {
      print("Error fetching tickets: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TechSupportProvider>(
      builder: (context, provider, child) => Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0.w,
            vertical: 16.0.h,
          ),
          child: FutureBuilder<void>(
            future: ticketsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CustomCircularProgressIndicator());
              }

              final tickets = provider.tickets;
              return Column(
                children: [
                  tickets.isEmpty
                      ? NoInfoWidget(
                          img: emptyChatIcon, msg: 'لا يوجد لديك رسائل')
                      : Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10.h),
                            itemCount: tickets.length,
                            itemBuilder: (context, index) {
                              print(tickets.length);
                              final ticket = tickets[index];
                              print('ticket: ${ticket.toJson()}');
                              print('ticket id: ${ticket.id}');
                              return CustomTicketCard(
                                ticket: ticket,
                              );
                            },
                          ),
                        ),
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomElevatedButton(
                      text: 'بدء رسالة جديدة',
                      onPressed: () async {
                        final user = await UserHelper.getUser();
                        user != null
                            ? Navigator.pushNamed(context, SupportScreen.id)
                            : loginFirstAlert(context);
                      },
                      backgroundColor: kprimaryColor,
                      textColor: grey9)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
