import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SimpleTitle extends StatelessWidget {
  final bool? location;
  final String title;

  const SimpleTitle({
    super.key,
    required this.title,
    this.location = false,
  });

  @override
  Widget build(BuildContext context) {
    return !location!
        ? Align(
            alignment: Alignment.centerRight,
            child: Text(
              textDirection: TextDirection.rtl,
              title,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  textDirection: TextDirection.rtl,
                  title,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 10.w),
              Icon(
                Icons.location_on_outlined,
                color: Colors.black,
              ),
            ],
          );
  }
}
