import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../config/constants.dart';
import '../provider.dart';

class RichTextEditorUpdate extends StatelessWidget {
  const RichTextEditorUpdate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UpdateAdSectionDetailsProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: grey8,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: quill.QuillSimpleToolbar(
              controller: provider.controller,
              config: quill.QuillSimpleToolbarConfig(
                  showFontSize: false,
                  showColorButton: false,
                  showBackgroundColorButton: false,
                  color: kprimaryColor),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0.sp),
              color: grey9,
              child: quill.QuillEditor.basic(controller: provider.controller),
            ),
          ),
        ],
      ),
    );
  }
}
