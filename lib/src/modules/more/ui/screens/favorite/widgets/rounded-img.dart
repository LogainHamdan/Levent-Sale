import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedImage extends StatelessWidget {
  final String assetPath;
  final bool isTopLeft;
  final bool isTopRight;
  final bool isBottomLeft;
  final bool isBottomRight;

  const RoundedImage({
    required this.assetPath,
    this.isTopLeft = false,
    this.isTopRight = false,
    this.isBottomLeft = false,
    this.isBottomRight = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: isTopLeft ? Radius.circular(5.r) : Radius.zero,
        topRight: isTopRight ? Radius.circular(5.r) : Radius.zero,
        bottomLeft: isBottomLeft ? Radius.circular(5.r) : Radius.zero,
        bottomRight: isBottomRight ? Radius.circular(5.r) : Radius.zero,
      ),
      child: assetPath.isNotEmpty
        ? Image.network(assetPath, fit: BoxFit.cover)
        : const SizedBox(),

    );
  }
}
