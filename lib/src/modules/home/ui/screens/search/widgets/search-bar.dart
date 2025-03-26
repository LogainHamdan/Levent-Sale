// import 'package:flutter/material.dart';
//
// import '../provider.dart';
//
// class SearchBarWidget extends StatelessWidget {
//   final SearchProvider provider;
//   const SearchBarWidget({super.key, required this.provider});
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: provider.searchController,
//       textAlign: TextAlign.right,
//       decoration: InputDecoration(
//         hintText: "عقارات",
//         hintStyle:  TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
//         prefixIcon:  Icon(Icons.search),
//         suffixIcon:  Icon(Icons.arrow_forward),
//         filled: true,
//         fillColor: Colors.grey.shade200,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }
// }
