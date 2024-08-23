import 'package:flutter/material.dart';

class UpBarWidget extends StatefulWidget {
  UpBarWidget({
    super.key,
  });

  @override
  State<UpBarWidget> createState() => _UpBarWidgetState();
}

class _UpBarWidgetState extends State<UpBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            ///Drawer Function Need to be done
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2,
                  spreadRadius: 2
                )
              ],
              color: Theme.of(context).cardColor,
              
            ),
            child: Icon(Icons.menu, color: Colors.black, size: 40
            ),
          ),
        ),
        Image.asset(
          "assets/PersonIcon/maleStudent.png",
          height: 80,
        ),
      ],
    );
  }
}
