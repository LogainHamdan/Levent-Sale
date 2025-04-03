import 'package:Levant_Sale/src/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../auth/ui/alerts/alert.dart';
import '../../../../home/ui/screens/home/data.dart';
import '../../../../home/ui/screens/search-filter/widgets/card.dart';
import '../../../../home/ui/screens/search-filter/widgets/horizontal-navigate.dart';
import '../../../../more/ui/screens/edit-profile/widgets/draggable-button.dart';
import '../create-ad/create-ad.dart';
import '../create-ad/provider.dart';
import '../section-details/provider.dart';
import '../section-details/section-details.dart';

class SectionTrack extends StatelessWidget {
  final int cardListIndex;

  const SectionTrack({super.key, required this.cardListIndex});

  @override
  Widget build(BuildContext context) {
    final stepperProvider = Provider.of<CreateAdProvider>(context);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: 6,
      itemBuilder: (context, index) {
        final provider = Provider.of<CreateAdProvider>(context);

        if (cardListIndex == 0) {
          return CustomCard(
            onTap: () => Navigator.push(
              context,
              createHorizontalPageRoute(CreateAdScreen(
                  lowerWidget: SectionTrack(
                cardListIndex: 1,
              ))),
            ),
            icon: SvgPicture.asset(height: 15.h, arrowLeftPath),
            title: categories[index]['name'],
          );
        }
        if (cardListIndex == 1) {
          return CustomCard(
            onTap: () => Navigator.push(
              context,
              createHorizontalPageRoute(CreateAdScreen(
                  lowerWidget: SectionTrack(
                cardListIndex: 2,
              ))),
            ),
            icon: SvgPicture.asset(height: 15.h, arrowLeftPath),
            title: 'شقق فاخرة و مفروشة',
          );
        }
        if (cardListIndex == 2) {
          return CustomCard(
              icon: SvgPicture.asset(height: 15.h, arrowLeftPath),
              title: "شقق في أبراح عالية",
              onTap: () {
                provider.nextStep();
                Navigator.push(
                  context,
                  createHorizontalPageRoute(CreateAdScreen(
                      bottomNavBar: DraggableButton('متابعة', onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateAdScreen(
                                    bottomNavBar: DraggableButton('متابعة',
                                        onPressed: () {
                                      stepperProvider.nextStep();
                                      showAdCreated(context);
                                    }),
                                    lowerWidget: SectionDetails(id: 1))));
                      }),
                      lowerWidget: SectionDetails(
                        id: 0,
                      ))),
                );
              });
        }
      },
    );
  }
}
