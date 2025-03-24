import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../home/ui/screens/home/data.dart';
import '../../../../home/ui/screens/search-filter/widgets/card.dart';
import '../create-ad/create-ad.dart';
import '../create-ad/provider.dart';
import '../section-details/section-details.dart';

class SectionTrack extends StatelessWidget {
  final int cardListIndex;

  const SectionTrack({super.key, required this.cardListIndex});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (context, index) {
              final provider = Provider.of<StepperProvider>(context);

              if (cardListIndex == 0) {
                return CustomCard(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateAdScreen(
                                  lowerWidget: SectionTrack(
                                cardListIndex: 1,
                              )))),
                  icon: Image.asset(
                      height: 10.h, 'assets/imgs_icons/general/arrow-left.png'),
                  title: categories[index]['name'],
                );
              }
              if (cardListIndex == 1) {
                return CustomCard(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateAdScreen(
                                  lowerWidget: SectionTrack(
                                cardListIndex: 2,
                              )))),
                  icon: Image.asset(
                      height: 10.h, 'assets/imgs_icons/general/arrow-left.png'),
                  title: 'شقق فاخرة و مفروشة',
                );
              }
              if (cardListIndex == 2) {
                return CustomCard(
                    icon: Image.asset(
                        height: 10.h,
                        'assets/imgs_icons/general/arrow-left.png'),
                    title: "شقق في أبراح عالية",
                    onTap: () {
                      provider.nextStep();

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateAdScreen(
                                      lowerWidget: SectionDetails(
                                    id: 0,
                                  ))));
                    });
              }
            },
          ),
        ),
      ),
    );
  }
}
