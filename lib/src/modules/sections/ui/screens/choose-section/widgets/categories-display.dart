import 'package:Levant_Sale/src/modules/home/ui/screens/home/provider.dart';
import 'package:Levant_Sale/src/modules/home/ui/screens/home/widgets/custom-indicator.dart';
import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/create-ad-choose-section-provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../../config/constants.dart';

class CategoriesDisplay extends StatelessWidget {
  final bool? forCreateAd;
  final Function() onSectionClicked;

  const CategoriesDisplay({
    super.key,
    required this.onSectionClicked,
    this.forCreateAd = false,
  });

  @override
  Widget build(BuildContext context) {
    final createProvider = Provider.of<CreateAdChooseSectionProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);

    if (createProvider.isLoading) {
      return const Center(child: CustomCircularProgressIndicator());
    }

    final categories = createProvider.rootCategories;

    if (categories.isEmpty) {
      return const Center(child: Text("No categories found"));
    }

    final createSelectedIndex = createProvider.selectedCategoryIndex;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: LayoutBuilder(builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];
            final isSelected = createSelectedIndex == index;

            return InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                forCreateAd!
                    ? createProvider.setSelectedCategory(index)
                    : homeProvider.selectCategory(category);

                Future.microtask(() => onSectionClicked());
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
                      color: forCreateAd!
                          ? isSelected
                              ? kprimaryColor
                              : grey8
                          : grey8,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: ClipOval(
                        child: Image.network(
                          category.imageUrl!,
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
        );
      }),
    );
  }
}
