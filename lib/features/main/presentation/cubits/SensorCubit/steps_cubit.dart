import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart';
import 'package:samla_app/features/main/data/repositories/steps_repository.dart';

part 'steps_state.dart';

// this cubit only for track the live steps that retrived from the sensor
class SensorCubit extends Cubit<SensorState> {
  SensorCubit() : super(SensorWorks(0));
  Completer<void> completer = Completer<void>();

  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) {
      // Registration has already occurred, so do nothing.
      return;
    }
    completer = Completer<void>();
    print('hello');
    await _requestPermissions();
    await completer.future;

    print('complete init steps');
  }

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;

  Future<void> _requestPermissions() async {
    await Permission.activityRecognition.request();
    await Permission.sensors.request();
    _initPlatformState();
  }

  void _initPlatformState() {
    _pedestrianStatusStream =   Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(_onPedestrianStatusChanged)
        .onError(_onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(_onStepCount).onError(onStepCountError);
  }

  // when the steps are updated
  void _onStepCount(StepCount event) {
    if (!_isInitialized) {
      _isInitialized = true;
      completer.complete();
    }
    emit(SensorWorks(event.steps));
  }

  void _onPedestrianStatusChanged(PedestrianStatus event) {
    print('onPedestrianStatusChanged: $event');
  }

  void _onPedestrianStatusError(error) {
    if (!_isInitialized) {
      _isInitialized = true;
      completer.complete();
    }

    emit(SensorError('Pedestrian Status not available'));
  }

  void onStepCountError(error) {
    if (!_isInitialized) {
      _isInitialized = true;
      completer.complete();
    }
    emit(SensorError('Step Count not available'));
  }
}
