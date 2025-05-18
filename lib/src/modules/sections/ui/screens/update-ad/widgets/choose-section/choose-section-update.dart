// import 'package:Levant_Sale/src/modules/home/ui/screens/home/provider.dart';
// import 'package:Levant_Sale/src/modules/sections/models/ad.dart';
// import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/create-ad-choose-section-provider.dart';
// import 'package:Levant_Sale/src/modules/sections/ui/screens/choose-section/widgets/categories-display.dart';
// import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/create-ad.dart';
// import 'package:Levant_Sale/src/modules/sections/ui/screens/track-section/track-section-branches.dart';
// import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/provider.dart';
// import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/update-ad.dart';
// import 'package:Levant_Sale/src/modules/sections/ui/screens/update-ad/widgets/choose-section/update-ad-choose-section-provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../track-section/track-section-update.dart';
//
// class SectionChooseUpdate extends StatelessWidget {
//   final AdModel ad;
//
//   const SectionChooseUpdate({super.key, required this.ad});
//
//   @override
//   Widget build(BuildContext context) {
//     final provider =
//         Provider.of<UpdateAdChooseSectionProvider>(context, listen: false);
//     provider.setSelectedCategory(ad.category?.id ?? 1);
//
//     return Consumer<UpdateAdProvider>(
//       builder: (context, createAdProvider, _) {
//         if (provider.rootCategories.isEmpty) {
//           return const Center(child: Text("No categories available"));
//         }
//
//         return SingleChildScrollView(
//           child: Column(
//             children: [
//               CategoriesDisplay(
//                 selectable: true,
//                 onSectionClicked: () async {
//                   createAdProvider.nextStep();
//
//                   await provider.fetchSubcategories(
//                     provider.selectedCategory?.id ?? 0,
//                   );
//
//                   WidgetsBinding.instance.addPostFrameCallback((_) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => UpdateAdScreen(
//                           lowerWidget: SectionTrackUpdate(
//                             ad: ad,
//                             subcategories: provider.subcategories,
//                           ),
//                           ad: ad,
//                         ),
//                       ),
//                     );
//                   });
//                 },
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
