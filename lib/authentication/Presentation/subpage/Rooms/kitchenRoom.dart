import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../../RealTimeDataBase/DataModel.dart';
import '../../../../RealTimeDataBase/fire_base.dart';
import '../../Widget/Componets/RoomProfile.dart';
import '../../Widget/Componets/appbar_widget.dart';
import '../../Widget/Componets/course_status.dart';
import 'package:firebase_database/firebase_database.dart';

class KitchenRoom extends StatefulWidget {
  final String title;
  final String path;
  const KitchenRoom({super.key, required this.title, required this.path});

  @override
  State<KitchenRoom> createState() => _KitchenRoomState();
}

class _KitchenRoomState extends State<KitchenRoom>
    with TickerProviderStateMixin {
  final DataBaseService _dbService = DataBaseService();
  StreamSubscription<DataSnapshot>? _dataSubscription;
  late final AnimationController _fireAlarmController;
  late final AnimationController _fanController;

  bool fanStatus = true;
  HomeAutomation? _homeAutomation;

  @override
  void initState() {
    super.initState();
    _fireAlarmController = AnimationController(vsync: this);
    _fanController = AnimationController(vsync: this);
    _loadData();
  }

  ///FireAlarm
  void _updateFireAlarmAnimation() {
    if (_homeAutomation?.kitchen.fireAlarm ?? false) {
      if (!_fireAlarmController.isAnimating) {
        _fireAlarmController.repeat(); // Loop the animation
      }
    } else {
      if (_fireAlarmController.isAnimating) {
        _fireAlarmController.stop(); // Stop the animation
        _fireAlarmController.reset(); // Optionally reset the animation
      }
    }
  }
  void _toggleMainLight() async {
    if (_homeAutomation == null) return;

    final newMainLightStatus = !_homeAutomation!.livingRoom.mainLightBulb;

    setState(() {
      _homeAutomation!.livingRoom.mainLightBulb = newMainLightStatus;
    });

    try {
      final updatedLivingRoom = _homeAutomation!.livingRoom.copyWith(mainLightBulb: newMainLightStatus);
      await _dbService.updateData('HomeAutomation/livingRoom', updatedLivingRoom.toJson());
    } catch (e) {
      print('Failed to update main light status: $e');
    }
  }
  ///FanStatusStop
  void _updateFanAnimation() {
    print(
        "Updating fan animation. Fan status: ${_homeAutomation?.kitchen.ventilationFan}");
    if (_homeAutomation?.kitchen.ventilationFan ?? false) {
      if (!_fanController.isAnimating) {
        if (_fanController.duration == null) {
          // You might need to handle this case differently if duration is not available
          print("Animation duration is not set.");
        } else {
          print("Starting fan animation.");
          _fanController.repeat(); // Loop the animation
        }
      }
    } else {
      if (_fanController.isAnimating) {
        print("Stopping fan animation.");
        _fanController.stop(); // Stop the animation
        _fanController.reset(); // Optionally reset the animation
      }
    }
  }

  void _fanSwitch() async {
    if (_homeAutomation == null) return;

    final fanStatus = !_homeAutomation!.kitchen.ventilationFan;

    setState(() {
      _homeAutomation!.kitchen.ventilationFan = fanStatus;
    });

    try {
      final updatedKitchenRoom =
      _homeAutomation!.kitchen.copyWith(ventilationFan: fanStatus);
      await _dbService.updateData(
          'HomeAutomation/kitchen', updatedKitchenRoom.toJson());
    } catch (e) {
      print('Failed to update fan status: $e');
    }
  }

  ///RealTimeLoadData
  Future<void> _loadData() async {
    try {
      final data = await _dbService.readData('HomeAutomation');
      final homeAutomation = HomeAutomation.fromJson(data);
      if (!mounted) return; // Check if widget is still in the tree
      setState(() {
        _homeAutomation = homeAutomation;
      });
    } catch (error) {
      print('Error reading data: $error');
    }

    // Set up real-time updates
    _dbService.listenToData('HomeAutomation', (data) {
      final homeAutomation = HomeAutomation.fromJson(data);
      setState(() {
        _homeAutomation = homeAutomation;
        _updateFanAnimation();
        _updateFireAlarmAnimation();
      });
    });
  }

  @override
  void dispose() {
    _dataSubscription?.cancel();
    _fireAlarmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BackIcon(),
      body: ListView(
        children: [
          RoomProfile(title: widget.title, path: widget.path),
          if (_homeAutomation != null) ...[
            ///FireAlarm
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.only(top: 15, left: 30, right: 30, bottom: 40),
              child: Column(
                children: [
                  const Text(
                    "Fire Detection",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                        child: Lottie.asset("lottieAnimation/alarm.json",
                          controller: _fireAlarmController,
                          onLoaded: (composition){
                            _fireAlarmController.duration = composition.duration;
                            _updateFireAlarmAnimation();
                          },
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HouseStatus(
                            title: "Gas Leakage",
                            isFireDetected: _homeAutomation!.kitchen.smoke ,
                            color: Color(0xFFFFFFFF),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          HouseStatus(
                            title: "Fire!Fire!",
                            isFireDetected: _homeAutomation!.kitchen.fireAlarm,
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
            // Container(
            //   padding: const EdgeInsets.only(
            //     top: 40,
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       ///WaterLevel
            //       Container(
            //         padding:
            //             const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(20),
            //           color: Color(0xFF7CB1F1),
            //         ),
            //         child: Column(
            //           children: [
            //             ///WaterLevel
            //             const Text(
            //               "Water Level",
            //               style: TextStyle(
            //                   color: Colors.white,
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 14),
            //             ),
            //             const SizedBox(
            //               height: 10,
            //             ),
            //             Container(
            //                 height: 70,
            //                 width: 100,
            //                 decoration: const BoxDecoration(
            //                     color: Color(0xFF7CB1F1),
            //                     boxShadow: [
            //                       BoxShadow(
            //                           color: Colors.white,
            //                           blurRadius: 3,
            //                           spreadRadius: 3),
            //                     ],
            //                     shape: BoxShape.circle),
            //                 child: Lottie.asset("lottieAnimation/waterLevel.json",
            //                     height: 50)),
            //
            //             SizedBox(
            //               height: 10,
            //             ),
            //             const Text(
            //               "Full",
            //               style: TextStyle(
            //                   color: Colors.white,
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 14),
            //             ),
            //           ],
            //         ),
            //       ),
            //
            //       ///Motor
            //       Container(
            //         padding:
            //             const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(20),
            //           color: Colors.black,
            //         ),
            //         child: Column(
            //           children: [
            //             ///Water Pump
            //             const Text(
            //               "Water Pump",
            //               style: TextStyle(
            //                   color: Colors.white,
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 14),
            //             ),
            //             const SizedBox(
            //               height: 10,
            //             ),
            //             Container(
            //               height: 70,
            //               width: 100,
            //               decoration: const BoxDecoration(
            //                   color: Color(0xFF7CB1F1),
            //                   boxShadow: [
            //                     BoxShadow(
            //                         color: Colors.white,
            //                         blurRadius: 3,
            //                         spreadRadius: 3),
            //                   ],
            //                   shape: BoxShape.circle),
            //               child: Lottie.asset(
            //                 "lottieAnimation/motor.json",
            //               ),
            //             ),
            //
            //             SizedBox(
            //               height: 10,
            //             ),
            //             const Text(
            //               "Start",
            //               style: TextStyle(
            //                   color: Color(0xFF7CB1F1),
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 14),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            GestureDetector(
              onTap: (){
                _showCustomDialog(context);
              },
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 120.0, vertical: 30),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
                            controller: _fanController, onLoaded: (composition) {
                              _updateFanAnimation();
                              _fanController.duration = composition.duration;
                            }, height: 70),
                      ),
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
                        value: _homeAutomation!.kitchen.ventilationFan,
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
                          _fanSwitch();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ] else
            Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Omg! Did you Forget to Turn Off the Fan?',style: TextStyle(color: Colors.red),),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                _toggleMainLight();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Open'),
            ),
            TextButton(
              onPressed: () {
                _toggleMainLight();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
