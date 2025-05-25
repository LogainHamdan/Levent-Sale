import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';

import '../../../../models/rating.dart';
import '../data.dart';
import '../provider.dart';

class CustomLikeButton extends StatelessWidget {
  final Rating review;
  final LikeType type;

  const CustomLikeButton({
    super.key,
    required this.review,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: 24.sp,
      likeCount: type == LikeType.like ? 5 : 2,
      countPostion: CountPostion.right,
      likeBuilder: (bool isLiked) {
        return Icon(
          isLiked
              ? (type == LikeType.like ? Icons.thumb_up : Icons.thumb_down)
              : (type == LikeType.like
                  ? Icons.thumb_up_alt_outlined
                  : Icons.thumb_down_alt_outlined),
          color: Colors.black,
        );
      },
      countBuilder: (int? count, bool isLiked, String text) {
        return Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: 14.sp),
        );
      },
    );
  }
}
