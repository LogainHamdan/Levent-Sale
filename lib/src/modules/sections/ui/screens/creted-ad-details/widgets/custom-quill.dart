// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;
//
// import '../provider.dart';
//
// class RichTextEditor extends StatelessWidget {
//   const RichTextEditor({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final editorProvider = Provider.of<EditorProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Rich Text Editor')),
//       body: Column(
//         children: [
//           /// **Toolbar (Upper Half)**
//           Container(
//             color: Colors.grey[200],
//             padding: const EdgeInsets.symmetric(vertical: 5),
//             child: quill.QuillSimpleToolbar(
//               controller: editorProvider.controller,
//             ),
//           ),
//
//           /// **Editor (Lower Half)**
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.all(8.0),
//               color: Colors.white,
//               child: quill.QuillEditor.basic(
//                 controller: editorProvider.controller,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
