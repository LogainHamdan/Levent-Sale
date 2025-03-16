// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../home/widgets/search-field.dart';
// import 'data.dart';
//
// class FilterScreen extends StatelessWidget {
//   static const id = '/filter';
//   const FilterScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Padding(
//               padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 22.h),
//               child: SearchField()),
//           Expanded(
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: categories.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: EdgeInsets.symmetric(vertical: 4),
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade100,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: ListTile(
//                     trailing: Text(
//                       categories[index]['title']!,
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                     leading: Image.asset(
//                       'assets/imgs_icons/general/arrow-left.png',
//                       height: 10.h,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
