import 'package:Levant_Sale/src/modules/home/ui/screens/home/provider.dart';
import 'package:Levant_Sale/src/modules/sections/models/root-category.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/section-details/section-details1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/constants.dart';
import '../../../../../sections/ui/screens/choose-section/create-ad-choose-section-provider.dart';
import '../../../../../sections/ui/screens/one-section/one-section.dart';

class SectionItem extends StatelessWidget {
  final Category category;
  final String img;

  const SectionItem({
    super.key,
    required this.category,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        provider.selectCategory(category);
        Navigator.pushNamed(context, Section.id);
      },
      child: Column(
        children: [
          Center(
            child: CircleAvatar(
              radius: 30.r,
              backgroundColor: grey7,
              child: Padding(
                padding: EdgeInsets.all(6.r),
                child: Image.network(
                  img,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h,),
          Text(category.name)
        ],
      ),
    );
  }
}
