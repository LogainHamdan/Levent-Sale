import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../home/ui/screens/home/data.dart';
import '../../../../home/ui/screens/search-filter/widgets/card.dart';
import '../section-details/section-details.dart';

class SectionTrack extends StatelessWidget {
  final int cardListIndex;
  static const id = '/track';

  const SectionTrack({super.key, required this.cardListIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 6,
          itemBuilder: (context, index) {
            if (cardListIndex == 0) {
              return CustomCard(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SectionTrack(
                              cardListIndex: 1,
                            ))),
                icon: Image.asset(
                    height: 10.h, 'assets/imgs_icons/general/arrow-left.png'),
                title: categories[index]['title']!,
              );
            }
            if (cardListIndex == 1) {
              return CustomCard(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SectionTrack(
                              cardListIndex: 2,
                            ))),
                icon: Image.asset(
                    height: 10.h, 'assets/imgs_icons/general/arrow-left.png'),
                title: 'شقق فاخرة و مفروشة',
              );
            }
            if (cardListIndex == 1) {
              return CustomCard(
                icon: Image.asset(
                    height: 10.h, 'assets/imgs_icons/general/arrow-left.png'),
                title: "شقق في أبراح عالية",
                onTap: () =>
                    Navigator.pushReplacementNamed(context, SectionDetails.id),
              );
            }
          },
        ),
      ),
    );
  }
}
