import 'package:flutter/material.dart';

class LampOnOff extends StatefulWidget {
  final String lampName;
  final bool tempStatus;
  final String onLight;
  final String offLight;
  const LampOnOff(
      {super.key,
      required this.tempStatus,
      required this.onLight,
      required this.offLight,
      required this.lampName});

  @override
  State<LampOnOff> createState() => _LampOnOffState();
}

class _LampOnOffState extends State<LampOnOff> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        children: [
          Image.asset(
            widget.tempStatus ? widget.onLight : widget.offLight,
            height: 120,
          ),
           Text(
            widget.lampName,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: "SecondaryFont",
            ),
          )
        ],
      ),
    );
  }
}
