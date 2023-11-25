import 'dart:async';

import 'package:samla_app/features/auth/auth_injection_container.dart';
import 'package:samla_app/features/main/data/repositories/steps_repository.dart';
import 'package:samla_app/features/main/domain/entities/StepsLog.dart';
import 'package:samla_app/features/main/presentation/cubits/SensorCubit/steps_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> stepsBackground(SensorCubit sensorCubit) async {
  // every one second update the steps
  int dummy = 0;
  var now = DateTime.now();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  StepsRepository repository = StepsRepository(prefs);
  // final SensorCubit sensorCubit = sl<SensorCubit>();
  // final StepsLogCubit stepsLogCubit = StepsLogCubit(prefs);
  

  // for testing
  final printLog = true;
  dummy++;
  if (printLog) print('timer is running');
  
  if (sensorCubit.state is SensorWorks) {
    print(
        'current sensor value ${sensorCubit.state is SensorWorks ? (sensorCubit.state as SensorWorks).reads : 0}');
    final stepsLog = await repository.addStepsLog(
        now,
        sensorCubit.state is SensorWorks
            ? (sensorCubit.state as SensorWorks).reads
            : 0);
   
  }
}
