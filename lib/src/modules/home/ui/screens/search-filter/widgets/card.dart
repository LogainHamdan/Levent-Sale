import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final Widget icon;
  final Function() onTap;

  const CustomCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
            trailing: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            leading: icon),
      ),
    );
  }
}
