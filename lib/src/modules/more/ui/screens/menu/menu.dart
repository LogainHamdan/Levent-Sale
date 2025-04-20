import 'package:Levant_Sale/src/modules/more/ui/screens/menu/provider.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/widgets/guest-column.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/menu/widgets/logged-column.dart';
import 'package:Levant_Sale/src/modules/more/ui/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../home/ui/screens/ads/widgets/title-row.dart';

class MenuScreen extends StatelessWidget {
  static const id = '/menu';

  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = Provider.of<MenuProvider>(context).isLoggedIn;
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: SizedBox(),
        backgroundColor: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.bodyLarge,
        title: TitleRow(
          title: 'المزيد',
          noBack: true,
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isLoggedIn
                ? Padding(
                    padding: EdgeInsets.all(16.0.sp),
                    child: LoggedInColumn(),
                  )
                : Padding(
                    padding: EdgeInsets.all(16.0.sp),
                    child: GuestColumn(),
                  ),
            Spacer(),
            // CustomBottomNavigationBar(),
          ],
        ),
      ),
    );
  }
}
