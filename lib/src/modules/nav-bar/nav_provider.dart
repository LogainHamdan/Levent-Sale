import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int selectedIndex = 0;
  int get currentIndex => selectedIndex;

  void setIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
////////////////////////////Solution///////////////
//import 'package:Levant_Sale/src/modules/home/ui/screens/home/home.dart';
// import 'package:Levant_Sale/src/modules/more/ui/screens/profile/profile.dart';
// import 'package:Levant_Sale/src/modules/sections/ui/screens/create-ad/create-ad.dart';
// import 'package:Levant_Sale/src/modules/sections/ui/screens/sections/sections.dart';
// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../../config/constants.dart';
// import '../sections/ui/screens/collection/my-collection.dart';
// import 'nav_provider.dart';
//
// class CustomBottomNavigationBar extends StatelessWidget {
//   const CustomBottomNavigationBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final List<IconData> iconList = [
//       Icons.menu,
//       Icons.shopping_bag_outlined,
//       Icons.grid_view,
//       Icons.home,
//     ];
//     final List<Widget> screens = [
//       ProfileScreen(),
//       MyCollectionScreen(empty: false),
//       Sections(),
//       HomeScreen(),
//     ];
//     final List<String> labels = ["المزيد", "تشكيلتي", "الأقسام", "الرئيسية"];
//     var provider = context.watch<NavigationProvider>();
//
//     return SafeArea(
//       child: Scaffold(
//         body: IndexedStack(
//           index: provider.selectedIndex,
//           children: screens,
//         ),
//         floatingActionButton: Padding(
//           padding: EdgeInsets.only(bottom: 8.0.h),
//           child: FloatingActionButton(
//             backgroundColor: kprimaryColor,
//             shape: CircleBorder(),
//             onPressed: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => CreateAdScreen()),
//             ),
//             child: Icon(
//               Icons.add,
//               color: Colors.white,
//               size: 35.sp,
//             ),
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 3.r,
//                 spreadRadius: 1.r,
//               ),
//             ],
//           ),
//           child: AnimatedBottomNavigationBar.builder(
//             height: 60.h,
//             itemCount: iconList.length,
//             tabBuilder: (int index, bool isActive) {
//               return GestureDetector(
//                 onTap: () => provider.setIndex(index),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 6.h),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         iconList[index],
//                         size: 24.sp,
//                         color: isActive ? kprimaryColor : grey4,
//                       ),
//                       SizedBox(height: 4.h),
//                       Text(
//                         labels[index],
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
//                           color: isActive ? kprimaryColor : grey4,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//             activeIndex: provider.selectedIndex,
//             gapLocation: GapLocation.center,
//             notchSmoothness: NotchSmoothness.smoothEdge,
//             onTap: (index) => provider.setIndex(index),
//             backgroundColor: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }
