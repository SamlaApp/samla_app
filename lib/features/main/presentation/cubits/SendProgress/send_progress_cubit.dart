import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/features/friends/presentation/cubit/profile_cubit.dart';
import 'package:samla_app/features/main/domain/entities/Progress.dart';
import 'package:samla_app/features/main/domain/entities/StepsLog.dart';
import 'package:samla_app/features/main/domain/repositories/progress_repository.dart';
import 'package:samla_app/features/main/home_di.dart';
import 'package:samla_app/features/main/presentation/cubits/ProgressCubit/progress_cubit.dart';
import 'package:samla_app/features/main/presentation/cubits/SensorCubit/steps_cubit.dart';
import 'package:samla_app/features/main/presentation/cubits/StepsLogCubit/steps_log_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'send_progress_state.dart';

class SendProgressCubit extends Cubit<SendProgressState> {
  SendProgressCubit(this.repository) : super(SendProgressInitial());
  final ProgressRepository repository;

  Future<void> sendProgress(Progress progress) async {
    emit(SendProgressLoading()); // Show loading state
    final result = await repository.sendProgress(progress);
    result.fold(
        (failure) => emit(const SendProgressError('Failed to send progress')),
        (success) {
      setCachedWeight(progress.weight as num);
      sl<ProgressCubit>().getProgress();
      emit(SendProgressSuccess());
    });
  }

   setCachedWeight(num weight) async {
    try {
      final success =
          await sl<SharedPreferences>().setString('weight', weight.toString());
    } catch (e) {
      emit(const SendProgressError('Failed to set cached weight'));
    }
  }

  getCachedWeight() {
    try {
      final weight = sl<SharedPreferences>().getString('weight');
      if (weight != null) {
        return num.parse(weight);
      } else {
        return sl<ProfileCubit>().userGoals.targetWeight ?? 0;
      }
    } catch (e) {
      return sl<ProfileCubit>().userGoals.targetWeight ?? 0;
    }
  }

  

  Future<void> refreashProgress() async {
    try {
      final sensorState = sl<SensorCubit>().state;
      await sl<ProgressCubit>().getProgress();
      if (sl<ProgressCubit>().state is! ProgressLoadedState) {
        throw Exception('Progress not loaded');
      }

      if ((sl<ProgressCubit>().state as ProgressLoadedState).progress.isEmpty) {
        if (sensorState is SensorWorks) {
          final oldSteps = sl<StepsLogCubit>().steps;
          final offset = sl<StepsLogCubit>().offset;
          final steps = sensorState.reads - offset + oldSteps;
          Progress progress = Progress(
            height: sl<AuthBloc>().user.height ?? 0,
            weight:  getCachedWeight(),
            calories: (steps * 0.7).toInt(),
            steps: steps,
            date: DateTime.now(),
          );
          print('before send to server: $progress.date');
          await sendProgress(progress);
          return Future<void>.value();
        }
      } else {
        if (sensorState is SensorWorks) {
          final lastProgress =
              (sl<ProgressCubit>().state as ProgressLoadedState).progress.first;
          final oldSteps = sl<StepsLogCubit>().steps;
          final offset = sl<StepsLogCubit>().offset;
          Progress progress = lastProgress.copyWith(
            steps: sensorState.reads - offset + oldSteps,
            date: DateTime.now(),
            weight: getCachedWeight(),
          );
          print('before send to server: $progress.date');
          await sendProgress(progress);
        }
      }
    } on Exception catch (e) {
      print('Error during refreash progress: $e');
    }
  }
}
