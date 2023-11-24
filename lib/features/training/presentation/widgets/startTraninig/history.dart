import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/themes/new_style.dart';
import '../../../domain/entities/ExerciseHistory.dart';
import '../../../domain/entities/ExerciseLibrary.dart';
import '../../cubit/History/history_cubit.dart';

class HistoryDialog extends StatelessWidget {
  final HistoryCubit historyCubit;
  final ExerciseLibrary selectedExercise;

  const HistoryDialog(
      {super.key, required this.historyCubit, required this.selectedExercise});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      bloc: historyCubit,
      builder: (context, state) {
        Widget dialogContent;
        if (state is HistoryLoadingState || state is NewHistoryLoadedState) {
          dialogContent = const CircularProgressIndicator(
            color: themeBlue,
            backgroundColor: themePink,
          );
        } else if (state is HistoryErrorState) {
          dialogContent = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: themeRed),
              const SizedBox(width: 8),
              Text(state.message),
            ],
          );
        } else if (state is HistoryEmptyState) {
          dialogContent = const Row(
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
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var entry in groupedHistory.entries)
                  buildSetDetails(entry, selectedExercise.bodyPart),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Icon(Icons.update, color: themeGrey, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        'Last updated: ${state.history.first.day}',
                        style: TextStyle(color: themeGrey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          dialogContent = const Text('Unhandled state');
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Day $day',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          for (var exercise in exercises)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      isCardio
                          ? 'Set ${exercise.sets}'
                          : 'Set ${exercise.sets}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  if (isCardio)
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${exercise.duration} min',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  if (isCardio)
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${exercise.distance} km',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  if (!isCardio)
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${exercise.repetitions} reps',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  if (!isCardio)
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${exercise.weight} kg',
                        style: const TextStyle(fontSize: 14),
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
