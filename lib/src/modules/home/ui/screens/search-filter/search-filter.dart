import 'package:Levant_Sale/src/modules/home/ui/screens/ads/ads.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/search-filter/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../home/data.dart';
import '../home/widgets/search-field.dart';
import 'data.dart';

class FilterScreen extends StatelessWidget {
  static const id = '/filter';
  final int cardListIndex;

  const FilterScreen({super.key, required this.cardListIndex});

  @override
  Widget build(BuildContext context) {
    TextEditingController filterController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 22.h),
                child: SearchField(
                  controller: filterController,
                )),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  if (cardListIndex == 0) {
                    return CustomCard(
                      onTap: () => Navigator.push(
                        context,
                        _createHorizontalPageRoute(
                          FilterScreen(cardListIndex: 1),
                        ),
                      ),
                      icon: Image.asset(
                          height: 10.h,
                          'assets/imgs_icons/general/arrow-left.png'),
                      title: categories[index]['name'],
                    );
                  }
                  if (cardListIndex == 1) {
                    return CustomCard(
                      onTap: () => Navigator.push(
                        context,
                        _createHorizontalPageRoute(
                          FilterScreen(cardListIndex: 2),
                        ),
                      ),
                      icon: Image.asset(
                          height: 10.h,
                          'assets/imgs_icons/general/arrow-left.png'),
                      title: 'شقق فاخرة و مفروشة',
                    );
                  }
                  if (cardListIndex == 2) {
                    return CustomCard(
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, AdsScreen.id),
                      icon: Image.asset(
                          height: 10.h,
                          'assets/imgs_icons/general/arrow-left.png'),
                      title: 'شقق فاخرة و مفروشة',
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Route _createHorizontalPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0); // الانتقال يبدأ من اليسار
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
