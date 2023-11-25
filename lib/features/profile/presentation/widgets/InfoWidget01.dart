// import 'package:flutter/material.dart';
// import 'package:samla_app/config/themes/common_styles.dart';
//
// class InfoWidget extends StatefulWidget {
//   const InfoWidget({Key? key}) : super(key: key);
//
//   @override
//   State<InfoWidget> createState() => _InfoWidgetState();
// }
//
// class _InfoWidgetState extends State<InfoWidget> {
//   final TextEditingController _heightController =
//       TextEditingController(text: '170');
//   final TextEditingController _weightController =
//       TextEditingController(text: '87');
//   final TextEditingController _caloriesController =
//       TextEditingController(text: '2000');
//   final TextEditingController _stepsController =
//       TextEditingController(text: '5000');
//
//   bool isEditing = false;
//
//   double steps = 0;
//
//   double maxSteps = 10000;
//
//   void _toggleEdit() {
//     setState(() {
//       isEditing = !isEditing;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 30),
//       child: Form(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'My Height',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14.0,
//                 color: Colors.green,
//               ),
//             ),
//             Container(
//               decoration: textField_decoration,
//               child: TextFormField(
//                 controller: _heightController,
//                 enabled: isEditing,
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   suffixText: 'cm',
//                   prefixIcon: Icon(
//                     Icons.accessibility,
//                     color: Colors.black38,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 15),
//             Text(
//               'My Weight',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14.0,
//                 color: Colors.green,
//               ),
//             ),
//             TextFormField(
//               controller: _weightController,
//               enabled: isEditing,
//               decoration: InputDecoration(
//                 suffixText: 'kg',
//                 prefixIcon: Icon(
//                   Icons.accessibility,
//                   color: Colors.black38,
//                 ),
//               ),
//             ),
//             SizedBox(height: 15),
//             Text(
//               'Target Calories:',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.green,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             isEditing
//                 ? Container(
//                     decoration: textField_decoration,
//                     padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               steps.toStringAsFixed(0),
//                               style: TextStyle(
//                                 fontSize: 16,
//                               ),
//                             ),
//                             Text(
//                               ' Steps/Day',
//                               style: TextStyle(
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SliderTheme(
//                           data: SliderTheme.of(context).copyWith(
//                             activeTrackColor: themePink,
//                             inactiveTrackColor: themeBlue,
//                             trackHeight: 3,
//                             thumbColor: themePink,
//                             thumbShape:
//                                 RoundSliderThumbShape(enabledThumbRadius: 8.0),
//                             overlayColor: Colors.red.withAlpha(25),
//                             overlayShape:
//                                 RoundSliderOverlayShape(overlayRadius: 15.0),
//                           ),
//                           child: Slider(
//                             value: steps,
//                             onChanged: (value) {
//                               setState(() {
//                                 steps = (value / 50).round() * 50.toDouble();
//                               });
//                             },
//                             min: 0,
//                             max: maxSteps,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 : TextFormField(
//                     controller: _caloriesController,
//                     enabled: isEditing,
//                     decoration: InputDecoration(
//                       suffixText: 'Calories/Day',
//                     ),
//                   ),
//             SizedBox(height: 5),
//             Text(
//               'Target Steps:',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.green,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             TextFormField(
//               controller: _stepsController,
//               enabled: isEditing,
//               decoration: InputDecoration(
//                 suffixText: 'Steps/Day',
//               ),
//             ),
//             SizedBox(height: 20),
//             Center(
//               child: isEditing
//                   ? ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         primary: themeDarkBlue,
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 20, vertical: 13),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         textStyle: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       onPressed: _toggleEdit,
//                       child: Text('Save Info'),
//                     )
//                   : ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         primary: themeDarkBlue,
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 20, vertical: 13),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         textStyle: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       onPressed: _toggleEdit,
//                       child: Text('Edit Info'),
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
