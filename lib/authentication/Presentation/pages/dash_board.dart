import 'package:flutter/material.dart';
import 'package:iot_group2_app/authentication/Presentation/subpage/Rooms/garage.dart';
import 'package:iot_group2_app/authentication/Presentation/subpage/Rooms/kitchenRoom.dart';
import 'package:iot_group2_app/authentication/Presentation/subpage/Rooms/livingRoom.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../Widget/Componets/build_rooms.dart';
import '../Widget/Componets/course_status.dart';
import '../Widget/Componets/main_title.dart';
import '../Widget/Componets/up_bar_widget.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            ///UpperWidgets
            UpBarWidget(),
            const SizedBox(
              height: 10,
            ),

            ///MainTitle
            MainTitle(
              title: "Group2",
              textStyle: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 15,
            ),

            MainTitle(
                title: "HomeAutomation",
                textStyle: Theme.of(context).textTheme.titleMedium),
            const SizedBox(
              height: 10,
            ),
            buildProgressBox(context),
            const SizedBox(
              height: 25,
            ),

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
            const SizedBox(
              height: 25,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildRooms(
                  title: 'Living Room',
                  path: 'assets/Rooms/livingRoom.png',
                  widgetRoom: LivingRoom(title: 'Living Room',path: 'assets/Rooms/livingRoom.png',),

                ),
                buildRooms(
                  title: 'Kitchen Room',
                  path: 'assets/Rooms/kitchen.png',
                  widgetRoom: KitchenRoom(title: 'Kitchen Room', path: 'assets/Rooms/kitchen.png',),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Center(
              child: buildRooms(
                title: 'Garage',
                path: 'assets/Rooms/garage.png',
                widgetRoom: GarageRoom(title: '', path: '',),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).cardColor,
        onPressed: () {},
        child: Icon(
          Icons.notifications,
          color: Theme.of(context).scaffoldBackgroundColor,
          size: 40,
        ),
      ),
    );
  }

  Widget buildProgressBox(context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double index = height * 0.03;
    final double index1 = height * 0.04;
    final double index2 = width * 0.06;
    final double index3 = width * 0.08;
    return Padding(
      padding: EdgeInsets.only(top: index),
      child: Container(
          width: width,
          padding: EdgeInsets.symmetric(horizontal: index2, vertical: 20),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(30)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///MainColumn
                  ///
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
                      const SizedBox(
                        height: 20,
                      ),

                      ///This Need to Be done
                      CircularPercentIndicator(
                        animation: true,
                        animationDuration: 5000,
                        progressColor: const Color(0xFF6489EB),
                        circularStrokeCap: CircularStrokeCap.round,
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.3),
                        percent: 1,
                        lineWidth: 10,
                        radius: 60,
                        center: const Text(
                          "40'C",
                          style: TextStyle(
                              fontFamily: "SecondaryFont",
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 120, // Define the height according to your design
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Fire Alarm
                        HouseStatus(
                          title: "Fire Safe",
                          isFireDetected: true,
                          color: Color(0xFF002757),
                        ),
                        HouseStatus(
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

                  ///MainColumn
                ],
              ),
              Divider(
                thickness: 1,
                color: Color(0xFF002757),
              ),
              const Center(
                child: const Text(
                  "Comfort",
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
          )),
    );
  }
}
