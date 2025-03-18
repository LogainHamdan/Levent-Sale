import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class EditorProvider extends ChangeNotifier {
  final quill.QuillController _controller = quill.QuillController.basic();

  quill.QuillController get controller => _controller;
}
