import 'package:flutter/material.dart';

class CourseStatus extends StatelessWidget {
  final String title;
  final int count;
  final IconData iconData;
  const CourseStatus({
    super.key,
    required this.title,
    required this.count,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontSize: 12,
            fontFamily: "SecondaryFont",
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Row(
          children: [
            Icon(
              iconData,
              color: Color(0xFFCFDAF9),
              size: 15,
            ),
            const SizedBox(
              width: 7,
            ),
            Text(
              count.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontFamily: "SecondaryFont",
                color: Colors.white,
              ),
            )
          ],
        )
      ],
    );
  }
}
