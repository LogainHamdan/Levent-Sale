import 'package:Levant_Sale/src/config/constants.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/provider.dart';
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
import '../section-details/section-details.dart';

class SectionTrack extends StatelessWidget {
  final int cardListIndex;
  final bool create;

  const SectionTrack(
      {super.key, required this.cardListIndex, required this.create});

  @override
  Widget build(BuildContext context) {
    final createAdProvider = Provider.of<CreateAdProvider>(context);
    final updateAdProvider = Provider.of<UpdateAdProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (context, index) {
          if (cardListIndex == 0) {
            return CustomCard(
              onTap: () => create
                  ? Navigator.push(
                      context,
                      createHorizontalPageRoute(CreateAdScreen(
                          lowerWidget: SectionTrack(
                        create: true,
                        cardListIndex: 1,
                      ))),
                    )
                  : Navigator.push(
                      context,
                      createHorizontalPageRoute(CreateAdScreen(
                          lowerWidget: SectionTrack(
                        create: false,
                        cardListIndex: 1,
                      ))),
                    ),
              icon: SvgPicture.asset(height: 15.h, arrowLeftPath),
              title: categories[index]['name'],
            );
          }
          if (cardListIndex == 1) {
            return CustomCard(
              onTap: () => create
                  ? Navigator.push(
                      context,
                      createHorizontalPageRoute(CreateAdScreen(
                          lowerWidget: SectionTrack(
                        create: true,
                        cardListIndex: 2,
                      ))),
                    )
                  : Navigator.push(
                      context,
                      createHorizontalPageRoute(CreateAdScreen(
                          lowerWidget: SectionTrack(
                        create: false,
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
                  create
                      ? createAdProvider.nextStep()
                      : updateAdProvider.nextStep();
                  create
                      ? Navigator.push(
                          context,
                          createHorizontalPageRoute(CreateAdScreen(
                              bottomNavBar:
                                  DraggableButton('متابعة', onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CreateAdScreen(
                                            bottomNavBar: DraggableButton(
                                                'متابعة', onPressed: () {
                                              createAdProvider.nextStep();
                                              createAdProvider.createAd(
                                                  token, context);
                                              showAdCreated(context);
                                            }),
                                            lowerWidget: SectionDetails(
                                                create: true, id: 1))));
                              }),
                              lowerWidget: SectionDetails(
                                id: 0,
                                create: true,
                              ))),
                        )
                      : Navigator.push(
                          context,
                          createHorizontalPageRoute(CreateAdScreen(
                              bottomNavBar:
                                  DraggableButton('متابعة', onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CreateAdScreen(
                                            bottomNavBar: DraggableButton(
                                                'متابعة', onPressed: () {
                                              updateAdProvider.nextStep();
                                              // updateAdProvider.createAd(
                                              //     token, context);
                                              showAdCreated(context);
                                            }),
                                            lowerWidget: SectionDetails(
                                              id: 1,
                                              create: false,
                                            ))));
                              }),
                              lowerWidget: SectionDetails(
                                id: 0,
                                create: false,
                              ))),
                        );
                });
          }
        },
      ),
    );
  }
}
