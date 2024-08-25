import 'package:flutter/material.dart';

class RoomProfile extends StatelessWidget {
  final String title;
  final String path;
  const RoomProfile({super.key, required this.title, required this.path});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: const Color(0xFF002757),
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Colors.black45,
                spreadRadius: 3,
                blurRadius: 2,
              )
            ],
            border: Border.all(
              color: Colors.white, // Border color
              width: 2.0, // Border width
            ),
          ),
          child: Image.asset(
            path,
            height: 60,
          ),
        ),
        SizedBox(height: 15,),
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF002757),
              fontSize: 22),
        ),
      ],
    );
  }
}
