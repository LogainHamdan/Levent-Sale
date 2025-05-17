import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSwitchTile extends StatelessWidget {
  const CustomSwitchTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.activeColor,
    required this.title,
  });
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title,
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
        SwitchListTile(
          value: value,
          activeColor: activeColor,
          onChanged: onChanged,
          visualDensity: VisualDensity(horizontal: 4.0),
          contentPadding: EdgeInsets.only(left: 16.0, right: 0),
        ),
      ],
    );
  }
}
