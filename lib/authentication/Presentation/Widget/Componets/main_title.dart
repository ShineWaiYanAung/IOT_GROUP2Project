import 'package:flutter/material.dart';

class MainTitle extends StatelessWidget {
  final String title;
  final TextStyle? textStyle;
  const MainTitle({
    this.textStyle,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double index = height * 0.02;
    return Container(
      alignment: Alignment.center,
      color: Colors.transparent,
      child: Text(title, style: textStyle),
    );
  }
}
