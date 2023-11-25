// import 'package:flutter/material.dart';
//
// class ExerciseDayWidget extends StatelessWidget {
//   final ExerciseDay exerciseDay;
//
//   ExerciseDayWidget({required this.exerciseDay});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildHistoryItem('Sets', exerciseDay.sets.toString()),
//         _buildHistoryItem('Repetitions', exerciseDay.repetitions.toString()),
//         _buildHistoryItem('Weight', exerciseDay.weight.toString()),
//         _buildHistoryItem('Distance', exerciseDay.distance.toString()),
//         _buildHistoryItem('Duration', '${exerciseDay.duration} seconds'),
//         if (exerciseDay.notes != null)
//           _buildHistoryItem('Notes', exerciseDay.notes!),
//       ],
//     );
//   }
//
//   Widget _buildHistoryItem(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(value),
//         ],
//       ),
//     );
//   }
// }
//
// class ExerciseDay {
//   final int? id;
//   final int exerciseLibraryId;
//   final int sets;
//   final int repetitions;
//   final double weight;
//   final double distance;
//   final int duration;
//   final String? notes;
//
//   ExerciseDay({
//     this.id,
//     required this.exerciseLibraryId,
//     required this.sets,
//     required this.repetitions,
//     required this.weight,
//     required this.distance,
//     required this.duration,
//     this.notes,
//   });
// }
//
// class ExerciseDayDialog extends StatelessWidget {
//   final List<ExerciseDay> exerciseHistory;
//
//   ExerciseDayDialog({required this.exerciseHistory});
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.8,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               padding: EdgeInsets.all(16),
//               color: Colors.blue,
//               child: Center(
//                 child: Text(
//                   'Exercise History',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: exerciseHistory.length,
//               itemBuilder: (context, index) {
//                 final exerciseDay = exerciseHistory[index];
//                 return ExerciseHistoryCard(exerciseDay: exerciseDay);
//               },
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text('Close'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ExerciseHistoryCard extends StatelessWidget {
//   final ExerciseDay exerciseDay;
//
//   ExerciseHistoryCard({required this.exerciseDay});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(16),
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Date:', // Replace with your date property
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Sets: ${exerciseDay.sets}',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[700],
//               ),
//             ),
//             Text(
//               'Repetitions: ${exerciseDay.repetitions}',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[700],
//               ),
//             ),
//             Text(
//               'Weight: ${exerciseDay.weight} kg',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[700],
//               ),
//             ),
//             Text(
//               'Distance: ${exerciseDay.distance} km',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[700],
//               ),
//             ),
//             Text(
//               'Duration: ${exerciseDay.duration} mins',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[700],
//               ),
//             ),
//             if (exerciseDay.notes != null && exerciseDay.notes!.isNotEmpty)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 8),
//                   Text(
//                     'Notes:',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     exerciseDay.notes!,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
