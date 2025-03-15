import 'package:flutter/material.dart';

import '../../../../../../config/constants.dart';

class OrRow extends StatelessWidget {
  const OrRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(color: grey6),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "OR",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Divider(color: grey6),
        ),
      ],
    );
  }
}
