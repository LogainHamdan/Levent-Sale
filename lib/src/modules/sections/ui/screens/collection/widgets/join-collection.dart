// import 'package:Levant_Sale/src/modules/sections/ui/screens/collection/widgets/tab-bar.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../provider.dart';
// import 'item-list.dart';
//
//
//
//
//
// class JoinMyCollection extends StatelessWidget {
//   const JoinMyCollection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var provider = Provider.of<TabProvider>(context);
//     return Scaffold(
//
//       body: Column(
//         children: [
//           TabBarWidget(),
//           Expanded(child: ItemList(provider.currentButton)),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.green,
//         child: Icon(Icons.add, color: Colors.white),
//         onPressed: () {},
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }
//
//
//
//
// // class BottomNavBar extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return BottomAppBar(
// //       shape: CircularNotchedRectangle(),
// //       notchMargin: 10,
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceAround,
// //         children: [
// //           IconButton(icon: Icon(Icons.menu), onPressed: () {}),
// //           IconButton(icon: Icon(Icons.shopping_bag, color: Colors.green), onPressed: () {}),
// //           SizedBox(width: 40),
// //           IconButton(icon: Icon(Icons.grid_view), onPressed: () {}),
// //           IconButton(icon: Icon(Icons.home), onPressed: () {}),
// //         ],
// //       ),
// //     );
// //   }
// // }
