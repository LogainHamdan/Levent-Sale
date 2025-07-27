import 'package:Levant_Sale/src/modules/auth/repos/user-helper.dart';
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
    return FutureBuilder<bool>(
      future: UserHelper.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              leading: SizedBox(),
              backgroundColor: Colors.white,
              titleTextStyle: Theme.of(context).textTheme.bodyLarge,
              title: TitleRow(
                title: 'المزيد',
                noBack: true,
              ),
            ),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              leading: SizedBox(),
              backgroundColor: Colors.white,
              titleTextStyle: Theme.of(context).textTheme.bodyLarge,
              title: TitleRow(
                title: 'المزيد',
                noBack: true,
              ),
            ),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final isLoggedIn = snapshot.data ?? false;
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
          body: SingleChildScrollView(
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
                // CustomBottomNavigationBar(),
              ],
            ),
          ),
        );
      },
    );
  }
}
