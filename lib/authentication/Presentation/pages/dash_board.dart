import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iot_group2_app/authentication/Presentation/subpage/Rooms/garage.dart';
import 'package:iot_group2_app/authentication/Presentation/subpage/Rooms/kitchenRoom.dart';
import 'package:iot_group2_app/authentication/Presentation/subpage/Rooms/livingRoom.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../RealTimeDataBase/DataModel.dart';
import '../../../RealTimeDataBase/fire_base.dart';
import '../../../RealTimeDataBase/loca_notification.dart';
import '../Widget/Componets/build_rooms.dart';
import '../Widget/Componets/course_status.dart';
import '../Widget/Componets/main_title.dart';
import '../Widget/Componets/up_bar_widget.dart';
import 'package:lottie/lottie.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final DataBaseService _dbService = DataBaseService();
  HomeAutomation? _homeAutomation;
  bool _isLoading = true;
  bool isRedBackground = false; // To control background color flashing
  Timer? _flashTimer; // Timer for flashing the background
  Timer? _notificationTimer; // Timer for sending notifications

  @override
  void dispose() {
    _flashTimer?.cancel(); // Cancel the flash timer when the widget is disposed
    _notificationTimer?.cancel(); // Cancel the notification timer when the widget is disposed
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }


  Future<void> _loadData() async {
    try {
      final data = await _dbService.readData('HomeAutomation');
      final homeAutomation = HomeAutomation.fromJson(data);
      setState(() {
        _homeAutomation = homeAutomation;
        _isLoading = false; // Data has been loaded
        if (_homeAutomation?.kitchen.fireAlarm ?? false) {
          LocalNotifications.showFireAlarmNoti(
              title: "Fire Alert!",
              body: "Your home is on fire! Please take immediate action.",
              payload: "FireAlarm"
          );
          _startFlashingBackground(); // Start flashing effect when fire alarm is triggered
          _startFireNotification(); // Start notifications for fire
        } else {
          _stopFlashingBackground(); // Stop flashing effect when fire alarm is cleared
          _stopFireNotification(); // Stop notifications
        }
        print("Fire Alarm: ${_homeAutomation?.kitchen.fireAlarm}");
      });
    } catch (error) {
      print('Error reading data: $error');
      setState(() {
        _isLoading = false; // Stop loading even if there's an error
      });
    }

    // Set up real-time updates
    _dbService.listenToData('HomeAutomation', (data) {
      final homeAutomation = HomeAutomation.fromJson(data);
      setState(() {
        _homeAutomation = homeAutomation;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (_homeAutomation?.kitchen?.fireAlarm ?? false)
          ? (isRedBackground ? Colors.red : Theme.of(context).scaffoldBackgroundColor)
          : Theme.of(context).scaffoldBackgroundColor,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            UpBarWidget(),
            const SizedBox(height: 10),
            MainTitle(
              title: "Group2",
              textStyle: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 15),
            MainTitle(
                title: "HomeAutomation",
                textStyle: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            buildProgressBox(context, _homeAutomation),
            const SizedBox(height: 25),
            const MainTitle(
              title: "Rooms",
              textStyle: TextStyle(
                letterSpacing: 2,
                fontSize: 25,
                fontFamily: 'SecondaryFont',
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildRooms(
                  title: 'Living Room',
                  path: 'assets/Rooms/livingRoom.png',
                  widgetRoom: LivingRoomUI(title: 'Living Room', path: 'assets/Rooms/livingRoom.png'),
                ),
                const buildRooms(
                  title: 'Kitchen Room',
                  path: 'assets/Rooms/kitchen.png',
                  widgetRoom: KitchenRoom(title: 'Kitchen Room', path: 'assets/Rooms/kitchen.png'),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Center(
              child: buildRooms(
                title: 'Garage',
                path: 'assets/Rooms/garage.png',
                widgetRoom: GarageRoom(title: 'Garage', path: 'assets/Rooms/garage.png'),
              ),
            ),
          ],
        ),
      ),

    );
  }

  Widget buildProgressBox(BuildContext context, HomeAutomation? homeAutomationData) {
    if (homeAutomationData == null) {
      return SizedBox.shrink(); // Return an empty widget if no data is available
    }

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double index = height * 0.03;
    final double index2 = width * 0.06;

    return Padding(
      padding: EdgeInsets.only(top: index),
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(horizontal: index2, vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      "Temp",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        fontSize: 19,
                        fontFamily: "SecondaryFont",
                        color: Color(0xFF002757),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CircularPercentIndicator(
                      animation: true,
                      animationDuration: 5000,
                      progressColor: const Color(0xFF6489EB),
                      circularStrokeCap: CircularStrokeCap.round,
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.3),
                      percent: 1,
                      lineWidth: 10,
                      radius: 60,
                      center: Text(
                        homeAutomationData.livingRoom.temp.toString(),
                        style: const TextStyle(
                          fontFamily: "SecondaryFont",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HouseStatus(
                        title: "Fire Safe",
                        isFireDetected: homeAutomationData.kitchen.fireAlarm,
                        color: Color(0xFF002757),
                      ),
                      const HouseStatus(
                        title: "Suit Oxygen",
                        isFireDetected: false,
                        color: Color(0xFF002757),
                      ),
                      HouseStatus(
                        title: "Suit Oxygen",
                        isFireDetected: false,
                        color: Color(0xFF002757),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 1,
              color: Color(0xFF002757),
            ),
            homeAutomationData.kitchen.fireAlarm
                ? SizedBox(
              width: double.infinity,
              child: Lottie.asset(
                "lottieAnimation/fire_fire.json",
                height: 100,
                fit: BoxFit.fill,
              ),
            )
                : const Center(
              child: Text(
                "Home is Safe",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontSize: 22,
                  fontFamily: "SecondaryFont",
                  color: Color(0xFF002757),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _startFlashingBackground() {
    _flashTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        isRedBackground = !isRedBackground; // Toggle the background color
      });
    });
  }

  void _stopFlashingBackground() {
    _flashTimer?.cancel();
    setState(() {
      isRedBackground = false; // Reset the background when fire alarm is off
    });
  }

  void _startFireNotification() {
    // Start a periodic timer to send notifications every 2 seconds
    _notificationTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      // Notification sent every 2 seconds while there is fire
      LocalNotifications.showFireAlarmNoti(
          title: "Fire Alert!",
          body: "Your home is on fire! Please take immediate action.",
          payload: "FireAlarm"
      );
    });
  }

  void _stopFireNotification() {
    // Stop the periodic timer to stop sending notifications
    _notificationTimer?.cancel();
  }


}
