import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/features/training/domain/entities/ExerciseHistory.dart';
import 'package:samla_app/features/training/domain/repositories/history_repository.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(this.repository) : super(HistoryInitial());
  final HistoryRepository repository;


  @override
  Future<void> getHistory({required int id}) async {
    emit(HistoryLoadingState());
    final result = await repository.getHistory(id: id);
    result.fold(
            (failure) => emit(const HistoryErrorState('Failed to fetch history')),
            (history) {
          if (history.isEmpty) {
            print('empty');
            emit(HistoryEmptyState());
            return;
          }
          emit(HistoryLoadedState(history.cast()));
        });
  }

  @override
  Future<void> addHistory({required int set,required int duration,required int repetitions,required int weight,required int distance,required String notes,required int exercise_library_id}) async {
    emit(HistoryLoadingState());
    final result = await repository.addHistory(set: set,duration: duration,repetitions: repetitions,weight: weight,distance: distance,notes: notes,exercise_library_id: exercise_library_id);
    result.fold(
            (failure) => emit(const HistoryErrorState('Failed to add history')),
            (history) {emit(NewHistoryLoadedState(history));
    });
  }
}