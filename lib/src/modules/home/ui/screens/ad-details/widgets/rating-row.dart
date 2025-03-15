import 'package:flutter/material.dart';

class RatingRow extends StatelessWidget {
  final int stars;
  final int count;
  final double value;

  const RatingRow({
    super.key,
    required this.stars,
    required this.count,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$count',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.green[100],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              minHeight: 5,
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Icon(Icons.star, color: Colors.amber, size: 24),
        Text(
          '$stars',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
