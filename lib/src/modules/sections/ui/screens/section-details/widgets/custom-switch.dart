import 'package:flutter/material.dart';

class CustomSwitchTile extends StatelessWidget {
  const CustomSwitchTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.activeColor,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      activeColor: activeColor,
      onChanged: onChanged,
      visualDensity: VisualDensity(horizontal: 4.0),
      contentPadding: EdgeInsets.only(left: 16.0, right: 0),
    );
  }
}
