import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/constants.dart';
import '../../../../../home/ui/screens/home/data.dart';
import '../choose-section-provider.dart';

class CategoriesDisplay extends StatelessWidget {
  final bool? selectable;
  final Function() onSectionClicked;

  const CategoriesDisplay(
      {super.key, required this.onSectionClicked, this.selectable = false});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChoosesSectionProvider>(context);
    final selectedIndex = provider.selectedCategoryIndex;

    return SizedBox(
      height: 820.h,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: categoryNames.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.9,
        ),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            onTap: () {
              provider.setSelectedCategory(index);
              Future.delayed(const Duration(milliseconds: 400), () {
                onSectionClicked();
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  height: 85.h,
                  width: 98.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectable!
                        ? isSelected
                            ? kprimaryColor
                            : grey8
                        : grey8,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: ClipOval(
                      child: Image.asset(
                        categoryImages[index],
                        height: 30.h,
                        width: 30.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Expanded(
                  child: Text(
                    categoryNames[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: kprimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
