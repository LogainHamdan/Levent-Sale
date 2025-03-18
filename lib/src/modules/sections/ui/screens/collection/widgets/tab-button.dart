// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../provider.dart';
//
// class TabButton extends StatelessWidget {
//   final String text;
//   final int index;
//
//   TabButton({required this.text, required this.index});
//
//   @override
//   Widget build(BuildContext context) {
//     var provider = Provider.of<TabProvider>(context);
//     return GestureDetector(
//       onTap: () => provider.changeTab(index),
//       child: Column(
//         children: [
//           Text(
//             text,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: provider.currentIndex == index ? Colors.green : Colors.black,
//             ),
//           ),
//           if (provider.currentIndex == index)
//             Container(
//               height: 3,
//               width: 60,
//               color: Colors.green,
//             ),
//         ],
//       ),
//     );
//   }
// }
