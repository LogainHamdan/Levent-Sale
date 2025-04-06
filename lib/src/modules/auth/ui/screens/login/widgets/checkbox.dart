import 'package:flutter/material.dart';

import '../../../../../../config/constants.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCheckBox extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  final String title;

  const CustomCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          visualDensity: VisualDensity.compact, // Reduces internal padding
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Removes extra tap area
          value: value,
          onChanged: (bool? newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
          fillColor: WidgetStateProperty.resolveWith((states) {
            return value ? kprimaryColor : Colors.white;
          }),
          checkColor: Colors.white,
          activeColor: kprimaryColor,
          focusColor: kprimaryColor,
        ),
    SizedBox(width:     title==""?0:8), // Add space between checkbox and text
        title==""?SizedBox():  Text(
          title,
          style: GoogleFonts.tajawal(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
