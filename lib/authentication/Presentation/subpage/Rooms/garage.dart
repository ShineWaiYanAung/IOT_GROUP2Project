import 'package:flutter/material.dart';

class GarageRoom extends StatefulWidget {
  final String title;
  final String path;
  const GarageRoom({super.key, required this.title, required this.path});

  @override
  State<GarageRoom> createState() => _GarageRoomState();
}

class _GarageRoomState extends State<GarageRoom> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
