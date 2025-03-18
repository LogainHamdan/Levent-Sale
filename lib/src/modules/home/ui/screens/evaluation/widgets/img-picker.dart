import 'dart:io';
import 'package:Levant_Sale/src/modules/home/ui/screens/evaluation/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ImagePickerWidget extends StatelessWidget {
  final Widget icon;
  const ImagePickerWidget({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<EvaluationProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(onTap: () => imageProvider.pickImage(), child: icon),
        if (imageProvider.selectedImage != null) ...[
          SizedBox(height: 12.h),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.file(
                  imageProvider.selectedImage!,
                  width: 70,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 2,
                right: 2,
                child: GestureDetector(
                  onTap: () => imageProvider.removeImage(),
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
