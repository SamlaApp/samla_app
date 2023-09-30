import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'training_state.dart';

class TrainingCubit extends Cubit<TrainingState> {
  TrainingCubit() : super(TrainingInitial());
}
