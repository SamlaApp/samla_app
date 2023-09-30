import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'nutrition_state.dart';

class NutritionCubit extends Cubit<NutritionState> {
  NutritionCubit() : super(NutritionInitial());
}
