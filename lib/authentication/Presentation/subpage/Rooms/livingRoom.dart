import 'package:flutter/material.dart';
import 'package:iot_group2_app/authentication/Presentation/Widget/Componets/Lamp.dart';
import 'package:iot_group2_app/authentication/Presentation/Widget/Componets/RoomProfile.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:iot_group2_app/authentication/Presentation/Widget/Componets/course_status.dart';
import '../../Widget/Componets/appbar_widget.dart';
import 'package:lottie/lottie.dart';

class LivingRoom extends StatefulWidget {
  final String title;
  final String path;
  const LivingRoom({super.key, required this.title, required this.path});

  @override
  State<LivingRoom> createState() => _LivingRoomState();
}

class _LivingRoomState extends State<LivingRoom> {
  bool mainLight = true;
  bool tempStatus = true;
  bool fanStatus = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BackIcon(),
      body: ListView(
        children: [
          RoomProfile(title: widget.title, path: widget.path),
          Container(
            padding: const EdgeInsets.only(
              top: 40,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ///FanSwitch
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Column(
                    children: [
                      Container(
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                              color: Color(0xFF7CB1F1),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 3,
                                    spreadRadius: 3),
                              ],
                              shape: BoxShape.circle),
                          child: Lottie.asset("lottieAnimation/fan.json",
                              height: 70)),
                      const SizedBox(
                        height: 20,
                      ),
                      FlutterSwitch(
                        width: 60.0,
                        activeColor: Color(0xFF7CB1F1),
                        inactiveColor: Colors.white,

                        height: 30.0,
                        valueFontSize: 12.0,
                        toggleSize: 20.0,
                        toggleColor: Color(0xFF7CB1F1),
                        activeToggleColor: Colors.white,
                        value: fanStatus,
                        borderRadius: 30.0,
                        padding: 2.0,
                        showOnOff: true,
                        activeTextColor: Colors.black,
                        inactiveTextColor: Colors.black,
                        activeText: "ON", // Customizable On text
                        inactiveText: "OFF", // Customizable Off text
                        activeTextFontWeight:
                            FontWeight.bold, // Optional: Set font weight
                        inactiveTextFontWeight:
                            FontWeight.bold, // Optional: Set font weight
                        onToggle: (val) {
                          setState(() {
                            fanStatus = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                ///Temp
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: tempStatus
                        ? const Color(0xFF7CB1F1)
                        : Colors.red.withOpacity(0.8),
                  ),
                  child: Column(
                    children: [
                      ///Snow
                      SizedBox(
                          height: 110,
                          width: 100,
                          child: Lottie.asset(
                              tempStatus
                                  ? "lottieAnimation/condition/snow.json"
                                  : "lottieAnimation/condition/hot.json",
                              height: 100)),
                      const SizedBox(
                        height: 10,
                      ),

                      const Text(
                        "25'C",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          ///FireAlarm
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                      color: Color(0xFF7CB1F1),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white,
                            blurRadius: 1,
                            spreadRadius: 2),
                      ],
                      shape: BoxShape.circle),
                  child: Lottie.asset("lottieAnimation/alarm.json", height: 70),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Front Door",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    HouseStatus(
                      title: "No Person",
                      isFireDetected: true,
                      color: Color(0xFFFFFFFF),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///MainLamp
                GestureDetector(
                    onTap: () {
                      setState(() {
                        mainLight = !mainLight;
                      });
                      print("MainLight $mainLight");
                    },
                    child: LampOnOff(
                        tempStatus: mainLight,
                        onLight: "assets/FunctionIcon/RightLamp/rightLamp.png",
                        offLight: "assets/FunctionIcon/RightLamp/rightLightLamp.png",
                        lampName : "MainLamp"),),
                ///Lamps
                GestureDetector(
                  onTap: () {
                    setState(() {
                      mainLight = !mainLight;
                    },);
                    print("MainLight $mainLight");
                  },
                  child: LampOnOff(
                      tempStatus: mainLight,
                      onLight: "assets/FunctionIcon/LeftLamp/leftLamp.png",
                      offLight: "assets/FunctionIcon/LeftLamp/leftLightLamp.png",
                      lampName : "Lamps"),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
