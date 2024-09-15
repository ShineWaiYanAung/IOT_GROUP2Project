import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:iot_group2_app/authentication/Presentation/Widget/Componets/Lamp.dart';
import 'package:iot_group2_app/authentication/Presentation/Widget/Componets/RoomProfile.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:iot_group2_app/authentication/Presentation/Widget/Componets/course_status.dart';
import '../../../../RealTimeDataBase/DataModel.dart';
import '../../../../RealTimeDataBase/fire_base.dart';
import '../../Widget/Componets/appbar_widget.dart';
import 'package:lottie/lottie.dart';

class LivingRoomUI extends StatefulWidget {
  final String title;
  final String path;
  LivingRoomUI({super.key, required this.title, required this.path});

  @override
  State<LivingRoomUI> createState() => _LivingRoomUIState();
}

class _LivingRoomUIState extends State<LivingRoomUI> with TickerProviderStateMixin{
  final DataBaseService _dbService = DataBaseService();
  StreamSubscription<DataSnapshot>? _dataSubscription;
  late final AnimationController _frontAlarmController;
  late final AnimationController _fanController;

  bool fanStatus = true;
  HomeAutomation? _homeAutomation;



  @override
  void initState() {
    super.initState();
    _frontAlarmController = AnimationController(vsync: this);
    _fanController = AnimationController(vsync: this);
    _loadData();
  }
  ///FireAlarm
  void _updateFireAlarmAnimation() {
    if (_homeAutomation?.livingRoom.firedoorlockSensor ?? false) {
      if (!_frontAlarmController.isAnimating) {
        _frontAlarmController.repeat(); // Loop the animation
      }
    } else {
      if (_frontAlarmController.isAnimating) {
        _frontAlarmController.stop(); // Stop the animation
        _frontAlarmController.reset(); // Optionally reset the animation
      }
    }
  }
  ///FanStatusStop
  void _updateFanAnimation() {
    print("Updating fan animation. Fan status: ${_homeAutomation?.livingRoom.fan}");
    if (_homeAutomation?.livingRoom.fan ?? false) {
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

    final fanStatus = !_homeAutomation!.livingRoom.fan;

    setState(() {
      _homeAutomation!.livingRoom.fan = fanStatus;
    });

    try {
      final updatedLivingRoom = _homeAutomation!.livingRoom.copyWith(fan: fanStatus);
      await _dbService.updateData('HomeAutomation/livingRoom', updatedLivingRoom.toJson());
    } catch (e) {
      print('Failed to update fan status: $e');
    }
  }

  ///RealTimeLoadData
  Future<void> _loadData() async {
    try {
      final data = await _dbService.readData('HomeAutomation');
      final homeAutomation = HomeAutomation.fromJson(data);
      if (mounted) {
        setState(() {
          _homeAutomation = homeAutomation;
        });
      }
    }  catch (error) {
      print('Error reading data: $error');

    }

    // Set up real-time updates
    _dbService.listenToData('HomeAutomation', (data) {
      final homeAutomation = HomeAutomation.fromJson(data);
      if (mounted) {
        setState(() {
          _homeAutomation = homeAutomation;
          _updateFanAnimation();
          _updateFireAlarmAnimation();
        });
      }
    });

  }

  ///FanSwitch


  //MainLight


  void _toggleLight() async {
    if (_homeAutomation == null) return;

    final lightStatus = !_homeAutomation!.livingRoom.lights;

    setState(() {
      _homeAutomation!.livingRoom.lights = lightStatus;
    });

    try {
      final updatedLivingRoom = _homeAutomation!.livingRoom.copyWith(lights: lightStatus);
      await _dbService.updateData('HomeAutomation/livingRoom', updatedLivingRoom.toJson());
      print("${updatedLivingRoom.lights}");
    } catch (e) {
      print('Failed to update light status: $e');
    }
  }

  @override
  @override
  void dispose() {
    _dataSubscription?.cancel(); // Ensure to cancel the subscription
    _frontAlarmController.dispose();
    _fanController.dispose();
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
            Container(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Fan Switch
                  Container(
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
                                spreadRadius: 3,
                              ),
                            ],
                            shape: BoxShape.circle,
                          ),
                          child: Lottie.asset("lottieAnimation/fan.json",
                              controller: _fanController,
                              onLoaded: (composition){
                                _updateFanAnimation();
                                _fanController.duration = composition.duration;

                              },
                              height: 70),

                        ),
                        const SizedBox(height: 20),
                        FlutterSwitch(
                          width: 60.0,
                          activeColor: Color(0xFF7CB1F1),
                          inactiveColor: Colors.white,
                          height: 30.0,
                          valueFontSize: 12.0,
                          toggleSize: 20.0,
                          toggleColor: Color(0xFF7CB1F1),
                          activeToggleColor: Colors.white,
                          value: _homeAutomation!.livingRoom.fan,
                          borderRadius: 30.0,
                          padding: 2.0,
                          showOnOff: true,
                          activeTextColor: Colors.black,
                          inactiveTextColor: Colors.black,
                          activeText: "ON",
                          inactiveText: "OFF",
                          activeTextFontWeight: FontWeight.bold,
                          inactiveTextFontWeight: FontWeight.bold,
                          onToggle: (val) {
                            _fanSwitch();
                          },
                        ),
                      ],
                    ),
                  ),

                  // Temperature
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: _homeAutomation!.livingRoom.temp < 50
                          ? const Color(0xFF7CB1F1)
                          : Colors.red.withOpacity(0.8),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 110,
                          width: 100,
                          child: Lottie.asset(
                            _homeAutomation!.livingRoom.temp < 50
                                ? "lottieAnimation/condition/snow.json"
                                : "lottieAnimation/condition/hot.json",
                            height: 100,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${_homeAutomation!.livingRoom.temp.toString()} 'C",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Fire Alarm
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
                          spreadRadius: 2,
                        ),
                      ],
                      shape: BoxShape.circle,
                    ),
                    child: Lottie.asset("lottieAnimation/alarm.json",
                        controller: _frontAlarmController,
                        onLoaded: (composition){
                          _frontAlarmController.duration = composition.duration;
                          _updateFireAlarmAnimation();
                        },
                        height: 70),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Front Door",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),
                      HouseStatus(
                        title: _homeAutomation!.livingRoom.firedoorlockSensor ? "Human Alert" : "No Person",
                        isFireDetected: _homeAutomation!.livingRoom.firedoorlockSensor,
                        color: Color(0xFFFFFFFF),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Lamps
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 120),
              child: GestureDetector(
                onTap: () {
                  _toggleLight();
                },
                child: LampOnOff(
                  tempStatus: _homeAutomation!.livingRoom.lights,
                  onLight: "assets/FunctionIcon/LeftLamp/leftLightLamp.png",
                  offLight: "assets/FunctionIcon/LeftLamp/leftLamp.png",
                  lampName: "Lamps",
                ),
              ),
            ),
          ] else
            Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
