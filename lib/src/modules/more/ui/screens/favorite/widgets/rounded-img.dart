import 'package:flutter/material.dart';

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
        topLeft: isTopLeft ? Radius.circular(5) : Radius.zero,
        topRight: isTopRight ? Radius.circular(5) : Radius.zero,
        bottomLeft: isBottomLeft ? Radius.circular(5) : Radius.zero,
        bottomRight: isBottomRight ? Radius.circular(5) : Radius.zero,
      ),
      child: Image.asset(assetPath, fit: BoxFit.cover),
    );
  }
}
