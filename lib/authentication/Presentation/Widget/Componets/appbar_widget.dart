import 'package:flutter/material.dart';

class BackIcon extends StatelessWidget implements PreferredSizeWidget {
  const BackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Image.asset("assets/backIcon.png"),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
