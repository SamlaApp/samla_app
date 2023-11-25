import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/main/data/repositories/steps_repository.dart';
import 'package:samla_app/features/main/domain/entities/StepsLog.dart';
import 'package:samla_app/features/main/presentation/cubits/SensorCubit/steps_cubit.dart';
import 'package:samla_app/features/notifications/notification_injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'steps_log_state.dart';

class StepsLogCubit extends Cubit<StepsLogState> {
  final sensorCubit = sl<SensorCubit>();
  final _stepsRepository = sl<StepsRepository>();
  int offset = -1;
  int steps = 0;

  StepsLogCubit(this.prefs) : super(StepsLogInitial());

  Future<void> init() async {
    if (sensorCubit.state is SensorWorks) {
      int sensor = (sensorCubit.state as SensorWorks).reads;
      var stepsLog = _stepsRepository.searchCache(DateTime.now());
      if (stepsLog != null) {
        if (stepsLog.sensorRead <= sensor) {
          offset = stepsLog.sensorRead;
          steps = stepsLog.steps;
        } else {
          offset = 0;
          steps = stepsLog.steps;
        }
      } else {
        offset = sensor;
        steps = 0;
      }
      await _stepsRepository.addStepsLog(DateTime.now(), sensor);
      emit(StepsLogInitial());
    } else {
      emit(StepsLogStateError('Sensor not working'));
    }
  }

  final SharedPreferences prefs;
}
