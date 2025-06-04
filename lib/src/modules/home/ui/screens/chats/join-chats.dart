import 'package:Levant_Sale/src/modules/home/ui/screens/chats/chats.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/chats/private-chats.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/chats/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/website-info/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/website-info/widgets/about-us.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/website-info/widgets/privacy-policy.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/tab-bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../auth/models/user.dart';
import '../../../../auth/repos/token-helper.dart';
import '../../../../auth/repos/user-helper.dart';
import '../ads/widgets/title-row.dart';
import '../home/widgets/custom-indicator.dart';

class JoinChats extends StatefulWidget {
  static const id = '/ChatListScreen';

  const JoinChats({super.key});

  @override
  State<JoinChats> createState() => _JoinChatsState();
}

class _JoinChatsState extends State<JoinChats> {
  User? currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserAndChats();
  }

  Future<void> _loadUserAndChats() async {
    final token = await TokenHelper.getToken();
    final user = await UserHelper.getUser();

    setState(() {
      currentUser = user;
    });

    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    await chatProvider.fetchChats(
      token: token ?? '',
      userId: user?.id ?? 0,
    );
    chatProvider.getChatsWithAds();
    chatProvider.getPrivateChats();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        title: const TitleRow(title: 'المحادثات'),
      ),
      body: SafeArea(
        child: currentUser == null
            ? const Center(child: CustomCircularProgressIndicator())
            : Column(
                children: [
                  SizedBox(
                    height: 40.h,
                    child: const TabBarWidget(
                      chats: true,
                      info: false,
                      tab1: 'بشأن الإعلان',
                      tab2: 'خاصة',
                      tab3: '',
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: provider.pageController,
                      onPageChanged: provider.updateIndex,
                      children: [
                        ChatListScreen(currentUser: currentUser!),
                        PrivateChatListScreen(currentUser: currentUser!),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
