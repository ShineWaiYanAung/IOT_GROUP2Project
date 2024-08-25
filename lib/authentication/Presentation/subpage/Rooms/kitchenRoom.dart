import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../Widget/Componets/RoomProfile.dart';
import '../../Widget/Componets/appbar_widget.dart';
import '../../Widget/Componets/course_status.dart';
class KitchenRoom extends StatefulWidget {
  final String title;
  final String path;
  const KitchenRoom({super.key, required this.title, required this.path});

  @override
  State<KitchenRoom> createState() => _KitchenRoomState();
}

class _KitchenRoomState extends State<KitchenRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BackIcon(),
      body: ListView(
        children: [
          RoomProfile(title: widget.title, path: widget.path),

          ///FireAlarm
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.only(top: 15, left: 30,right: 30,bottom: 40),
            child: Column(
              children: [
                const Text(
                  "Fire Detection",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                Row(
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
                        HouseStatus(
                          title: "Gas Leakage",
                          isFireDetected: true,
                          color: Color(0xFFFFFFFF),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        HouseStatus(
                          title: "Fire!Fire!",
                          isFireDetected: true,
                          color: Color(0xFFFFFFFF),
                        ),

                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          ///WaterLevelAndPump
          Container(
            padding: const EdgeInsets.only(
              top: 40,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                ///WaterLevel
                Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFF7CB1F1),
                  ),
                  child: Column(
                    children: [
                      ///WaterLevel
                      const Text(
                        "Water Level",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                          height: 70,
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
                          child: Lottie.asset("lottieAnimation/waterLevel.json",
                              height: 50)),

                      SizedBox(height: 10,),
                      const Text(
                        "Full",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                ///Motor
                Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black,
                  ),
                  child: Column(
                    children: [
                      ///Water Pump
                      const Text(
                        "Water Pump",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                          height: 70,
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
                          child: Lottie.asset("lottieAnimation/motor.json",
                              ),),

                      SizedBox(height: 10,),
                      const Text(
                        "Start",
                        style: TextStyle(
                            color: Color(0xFF7CB1F1),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120.0,vertical: 30),
            child: Container(
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
                    value: true,
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
                        // fanStatus = val;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
