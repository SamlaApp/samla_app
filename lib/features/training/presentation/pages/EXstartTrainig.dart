// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:samla_app/config/themes/common_styles.dart';
// import '../widgets/exercise_tile.dart';
// import 'ex.dart';
// import 'dart:async';
//
//
// class StartTraining extends StatefulWidget {
//
//   final int dayIndex;
//   final int templateId;
//
//   const StartTraining({Key? key, required this.dayIndex, required this.templateId}) : super(key: key);
//
//   @override
//   _StartTrainingState createState() => _StartTrainingState();
// }
//
// class _StartTrainingState extends State<StartTraining> {
//   final Routine routine =
//       dummyRoutines[0]; // Assuming you want to show the first routine
//   late Timer _timer;
//   int _seconds = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//
//   }
//
//   void startTimer() {
//     const oneSecond = Duration(seconds: 1);
//     _timer = Timer.periodic(oneSecond, (timer) {
//       setState(() {
//         _seconds++;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel(); // Cancel the timer to prevent memory leaks
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final minutes = _seconds ~/ 60;
//     final seconds = _seconds % 60;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(routine.title, style: TextStyle(color: Colors.white)),
//         backgroundColor: theme_green,
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.qr_code,
//               color: Colors.white,
//             ),
//             onPressed: () => Navigator.pushNamed(context, '/QRcode'),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(1.0, 15.0, 1.0, 80.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'Timer: ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: Container(
//                 child: PageView.builder(
//                   itemCount: routine.exercises.length,
//                   itemBuilder: (context, index) {
//                     return ExerciseTile(exercise: routine.exercises[index]);
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
