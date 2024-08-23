import 'package:flutter/material.dart';

class buildRooms extends StatelessWidget {
  final String title;
  final String path;
  // final Widget widgetRoom;
  const buildRooms({
    super.key,
    required this.title,
    required this.path,
    // required this.widgetRoom,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => widgetRoom,
        // ),);
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
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
                height: 50,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            const Text(
              "Living Room",
              style: TextStyle(
                color: Color(0xFF002757),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
