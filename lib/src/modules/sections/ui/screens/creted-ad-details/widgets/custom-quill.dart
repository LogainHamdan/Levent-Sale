import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

import '../../../../../../config/constants.dart';
import '../provider.dart';

class RichTextEditor extends StatelessWidget {
  const RichTextEditor({super.key});

  @override
  Widget build(BuildContext context) {
    final editorProvider = Provider.of<EditorProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: grey7,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: quill.QuillSimpleToolbar(
              controller: editorProvider.controller,
              config: quill.QuillSimpleToolbarConfig(
                  showFontSize: false,
                  showColorButton: false,
                  showBackgroundColorButton: false,
                  color: kprimaryColor),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: grey9,
              child: quill.QuillEditor.basic(
                controller: editorProvider.controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
