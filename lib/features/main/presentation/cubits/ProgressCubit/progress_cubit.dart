import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:samla_app/features/main/domain/entities/Progress.dart';
import 'package:samla_app/features/main/domain/repositories/progress_repository.dart';

part 'progress_state.dart';

class ProgressCubit extends Cubit<ProgressState> {
  ProgressCubit(this.repository) : super(ProgressInitial());
  final ProgressRepository repository;

  Future<void> getProgress() async {
    emit(ProgressLoadingState()); // Show loading state
    final result = await repository.getAllProgress();
    result.fold(
      (failure) => emit(ProgressErrorState('Failed to get progress')),
      (progress) => emit(ProgressLoadedState(progress)),
    );
  }

  //function that return a friend progress
  Future<void> getFriendProgress(int friendId,void Function(List<Progress>) callback) async {
    final result = await repository.getFriendProgress(friendId);
    result.fold((failure) {}, (progresses) {
      callback(progresses);
    });
  }
}
