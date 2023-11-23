// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// class CountdownTimer extends StatefulWidget {
//   @override
//   _CountdownTimerState createState() => _CountdownTimerState();
// }
//
// class _CountdownTimerState extends State<CountdownTimer> {
//   int _secondsRemaining = 0;
//   late Timer _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (_secondsRemaining > 0) {
//         setState(() {
//           _secondsRemaining--;
//         });
//       } else {
//         _timer.cancel(); // Stop the timer when countdown reaches 0
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel(); // Cancel the timer to avoid memory leaks
//     super.dispose();
//   }
//
//   void startCountdown() {
//     setState(() {
//       _secondsRemaining = 30; // Set the initial countdown value
//       _timer.cancel(); // Reset the timer
//       _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//         if (_secondsRemaining > 0) {
//           setState(() {
//             _secondsRemaining--;
//           });
//         } else {
//           _timer.cancel(); // Stop the timer when countdown reaches 0
//         }
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Countdown Timer Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Time remaining: $_secondsRemaining seconds',
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: startCountdown,
//               child: Text('Start Countdown'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
