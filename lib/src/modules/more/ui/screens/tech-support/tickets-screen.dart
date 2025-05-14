import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/auth/ui/screens/splash/widgets/custom-elevated-button.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/chats/no-info-widget.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/tech-support-screen.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/technical-support.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/tech-support/widgets/custom-card.dart';
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
    final provider = Provider.of<TechSupportProvider>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0.w,
          vertical: 16.0.h,
        ),
        child: FutureBuilder<void>(
          future: ticketsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
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
                            final ticket = tickets[index];
                            return GestureDetector(
                              onTap: () {},
                              child: CustomTicketCard(
                                ticket: ticket,
                              ),
                            );
                          },
                        ),
                      ),
                SizedBox(
                  height: 24.h,
                ),
                CustomElevatedButton(
                    text: 'بدء رسالة جديدة',
                    onPressed: () =>
                        Navigator.pushNamed(context, SupportScreen.id),
                    backgroundColor: kprimaryColor,
                    textColor: grey9)
              ],
            );
          },
        ),
      ),
    );
  }
}
