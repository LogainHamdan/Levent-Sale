import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/create-ad-choose-section-provider.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/update-ad-choose-section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/constants.dart';

class CategoriesDisplay extends StatelessWidget {
  final bool? create;
  final bool? selectable;
  final Function() onSectionClicked;

  const CategoriesDisplay({
    super.key,
    required this.onSectionClicked,
    this.selectable = false,
    this.create = true,
  });

  @override
  Widget build(BuildContext context) {
    final createProvider = Provider.of<CreateAdChooseSectionProvider>(context);
    final updateProvider = Provider.of<UpdateAdChooseSectionProvider>(context);

    final createSelectedIndex = createProvider.selectedCategoryIndex;
    final updateSelectedIndex = updateProvider.selectedCategoryIndex;
    final categories = createProvider.rootCategories;

    if (create! && createProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (!create! && updateProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      height: 860.h,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.9,
        ),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = create!
              ? createSelectedIndex == index
              : updateSelectedIndex == index;

          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            onTap: () {
              create!
                  ? createProvider.setSelectedCategory(index)
                  : updateProvider.setSelectedCategory(index);
              Future.delayed(const Duration(milliseconds: 400), () {
                onSectionClicked();
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
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
                      child: SvgPicture.asset(
                        category.imageUrl,
                        height: 30.h,
                        width: 30.w,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Expanded(
                  child: Text(
                    category.name,
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
