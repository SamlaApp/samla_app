import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/themes/common_styles.dart';
import '../../../domain/entities/ExerciseHistory.dart';
import '../../../domain/entities/ExerciseLibrary.dart';
import '../../cubit/History/history_cubit.dart';

class historyDialog extends StatelessWidget {
  final HistoryCubit historyCubit;
  final ExerciseLibrary selectedExercise;

  historyDialog({required this.historyCubit, required this.selectedExercise});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      bloc: historyCubit,
      builder: (context, state) {
        Widget dialogContent;

        if (state is HistoryLoadingState || state is NewHistoryLoadedState) {
          dialogContent = CircularProgressIndicator(
            color: themeBlue,
            backgroundColor: themePink,
          );
        } else if (state is HistoryErrorState) {
          dialogContent = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red),
              SizedBox(width: 8),
              Text(state.message),
            ],
          );
        } else if (state is HistoryEmptyState) {
          dialogContent = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.history_toggle_off, color: themeBlue),
              SizedBox(width: 8),
              Text('No history found'),
            ],
          );
        } else if (state is HistoryLoadedState) {
          final groupedHistory = <String?, List<ExerciseHistory>>{};
          for (final history in state.history) {
            groupedHistory.putIfAbsent(history.day, () => []).add(history);
          }

          dialogContent = SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var entry in groupedHistory.entries)
                  buildSetDetails(entry, selectedExercise.bodyPart),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Icon(Icons.update, color: Colors.grey, size: 20),
                      SizedBox(width: 4),
                      Text(
                        'Last updated: ${state.history.first.day}',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          dialogContent = Text('Unhandled state');
        }

        // Display dialog for the current state
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: dialogContent,
          ),
        );
      },
    );
  }

  Widget buildSetDetails(
      MapEntry<String?, List<ExerciseHistory>> entry, String bodyPart) {
    bool isCardio = bodyPart == 'cardio';
    var day = entry.key;
    var exercises = entry.value;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Day $day',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Divider(),
          for (var exercise in exercises)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      isCardio
                          ? 'Set ${exercise.sets}'
                          : 'Set ${exercise.sets}',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  if (isCardio)
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${exercise.duration} min',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  if (isCardio)
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${exercise.distance} km',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  if (!isCardio)
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${exercise.repetitions} reps',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  if (!isCardio)
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${exercise.weight} kg',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// BlocBuilder<HistoryCubit, HistoryState> buildHistory() {
//   return BlocBuilder<HistoryCubit, HistoryState>(
//       bloc: historyCubit,
//       builder: (context, state) {
//         Widget dialogContent;
//
//         if (state is HistoryLoadingState || state is NewHistoryLoadedState) {
//           dialogContent = CircularProgressIndicator(
//             color: theme_green,
//             backgroundColor: theme_pink,
//           );
//         } else if (state is HistoryErrorState) {
//           dialogContent = Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.error, color: Colors.red),
//               SizedBox(width: 8),
//               Text(state.message),
//             ],
//           );
//         } else if (state is HistoryEmptyState) {
//           dialogContent = Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.history_toggle_off, color: theme_green),
//               SizedBox(width: 8),
//               Text('No history found'),
//             ],
//           );
//         } else if (state is HistoryLoadedState) {
//           final groupedHistory = <String?, List<ExerciseHistory>>{};
//           for (final history in state.history) {
//             groupedHistory.putIfAbsent(history.day, () => []).add(history);
//           }
//
//           dialogContent = SingleChildScrollView(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 for (var entry in groupedHistory.entries)
//                   buildSetDetails(entry, selectedExercise.bodyPart),
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: 8),
//                   child: Row(
//                     children: [
//                       Icon(Icons.update, color: Colors.grey, size: 20),
//                       SizedBox(width: 4),
//                       Text(
//                         'Last updated: ${state.history.first.day}',
//                         style: TextStyle(color: Colors.grey, fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else {
//           dialogContent = Text('Unhandled state');
//         }
//
//         // Display dialog for the current state
//         return Dialog(
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           elevation: 0,
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: dialogContent,
//           ),
//         );
//       });
// }
//
