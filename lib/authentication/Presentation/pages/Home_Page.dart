// import 'package:flutter/material.dart';
// import '../../../RealTimeDataBase/DataModel.dart';
// import '../../../RealTimeDataBase/fire_base.dart';
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final DataBaseService _dbService = DataBaseService();
//   HomeAutomation? _homeAutomation;
//   bool _isLoading = true; // To track loading state
//
//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//   }
//
//   Future<void> _loadData() async {
//     try {
//       final data = await _dbService.readData('HomeAutomation');
//       final homeAutomation = HomeAutomation.fromJson(data);
//       setState(() {
//         _homeAutomation = homeAutomation;
//         _isLoading = false; // Data has been loaded
//       });
//     } catch (error) {
//       print('Error reading data: $error');
//       setState(() {
//         _isLoading = false; // Stop loading even if there's an error
//       });
//     }
//
//     // Set up real-time updates
//     _dbService.listenToData('HomeAutomation', (data) {
//       final homeAutomation = HomeAutomation.fromJson(data);
//       setState(() {
//         _homeAutomation = homeAutomation;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Automation', style: TextStyle(fontSize: 20)),
//       ),
//       body: Center(
//         child: _isLoading
//             ? CircularProgressIndicator() // Show loading indicator while data is being fetched
//             : _homeAutomation == null
//             ? Text('No data available')
//             : Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Living Room Light: ${_homeAutomation!.livingRoom.mainLightBulb}'),
//             Text('Garage Door Open: ${_homeAutomation!.garage.doorOpen}'),
//             Text('Kitchen Fire Alarm: ${_homeAutomation!.kitchen.fireAlarm}'),
//           ],
//         ),
//       ),
//     );
//   }
// }
