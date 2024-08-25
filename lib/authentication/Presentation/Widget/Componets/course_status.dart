import 'package:flutter/material.dart';

class HouseStatus extends StatelessWidget {
  final String title;
  final bool isFireDetected;
  final Color color;
  const HouseStatus({
    super.key,
    required this.title,
    required this.isFireDetected, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            color: isFireDetected ? Colors.red : Colors.green,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(
          width: 7,
        ),
        Text(
          title,
          style:  TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontFamily: "SecondaryFont",
            color: color,
          ),
        )
      ],
    );
  }
}
