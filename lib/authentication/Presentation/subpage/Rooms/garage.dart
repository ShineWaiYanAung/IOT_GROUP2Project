import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../RealTimeDataBase/DataModel.dart';
import '../../../../RealTimeDataBase/fire_base.dart';
import '../../Widget/Componets/RoomProfile.dart';
import '../../Widget/Componets/appbar_widget.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../Widget/Componets/course_status.dart';
class GarageRoom extends StatefulWidget {
  final String title;
  final String path;
  const GarageRoom({super.key, required this.title, required this.path});

  @override
  State<GarageRoom> createState() => _GarageRoomState();
}

class _GarageRoomState extends State<GarageRoom> with TickerProviderStateMixin{


  final DataBaseService _dbService = DataBaseService();
  StreamSubscription<DataSnapshot>? _dataSubscription;
  late final AnimationController _garageController;


  bool fanStatus = true;
  HomeAutomation? _homeAutomation;

  @override
  void initState() {
    super.initState();
    _garageController = AnimationController(vsync: this);
    _loadData();
  }

  ///FireAlarm
  void _updateGarageAnimation() {
    if (_homeAutomation?.garage.doorOpen ?? false) {
      if (!_garageController.isAnimating) {
        _garageController.forward(); // Start the animation once
      }
    } else {
      if (_garageController.isAnimating) {
        _garageController.stop(); // Stop the animation if needed
        _garageController.reset(); // Optionally reset the animation
      }
    }
  }
  void _doorSwitch() async {
    if (_homeAutomation == null) return;

    final newDoorStatus = !_homeAutomation!.garage.doorOpen;

    setState(() {
      _homeAutomation!.garage.doorOpen = newDoorStatus;
    });

    try {

      final updatedGarage = _homeAutomation!.garage.copyWith(doorOpen: newDoorStatus);

      await _dbService.updateData(
          'HomeAutomation/garage', updatedGarage.toJson());
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
      if (!mounted) return; // Check if widget is still in the tree
      final homeAutomation = HomeAutomation.fromJson(data);
      setState(() {
        _homeAutomation = homeAutomation;
        _updateGarageAnimation();
      });
    });
  }

  @override
  void dispose() {
    _dataSubscription?.cancel();
    _garageController.dispose();
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
              child: Lottie.asset("lottieAnimation/garage.json",
                controller: _garageController,
                onLoaded: (composition){
                  _garageController.duration = composition.duration;
                  _updateGarageAnimation();
                },),

            ),
      GestureDetector(
        onTap: () {
          _doorSwitch();
        },
        child: Container(
          width: 100.0, // Width of the button
          height: 100.0, // Height of the button
          decoration: BoxDecoration(
            color: _homeAutomation!.garage.doorOpen ? Colors.red : Colors.black, // Toggle color
            shape: BoxShape.circle, // Make the button circular
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5), // Shadow color
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 10), // Shadow position
              ),
            ],
          ),
          child: Center(
            child: Text(
              _homeAutomation!.garage.doorOpen ? 'Close' : "Open",
              style: TextStyle(
                color: _homeAutomation!.garage.doorOpen ? Colors.black : Colors.white, // Toggle text color
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
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
}