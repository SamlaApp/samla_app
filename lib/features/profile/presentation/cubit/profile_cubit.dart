import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/features/profile/data/goals_repository.dart';
import 'package:samla_app/features/profile/domain/Goals.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GoalsRepository goalsRepository;
  final authbloc = sl.get<AuthBloc>();
  UserGoals userGoals = UserGoals();
  ProfileCubit(this.goalsRepository) : super(ProfileInitial());

  // implements functions in the Goals repository

  // set gender
  Future<void> setGender(String gender) async {
    final result = await goalsRepository.setGender(gender);
    result.fold((l) => emit(ProfileError(message: l.message)), (newUser) {
      authbloc.add(UpdateUserEvent(newUser.copyWith(
          accessToken: authbloc
              .user.accessToken))); // since it will not return the access token
      emit(ProfileInitial());
    });
  }

  // set height
  Future<void> setHeight(double height) async {
    final result = await goalsRepository.setHeight(height);
    result.fold((l) => emit(ProfileError(message: l.message)), (newUser) {
      authbloc.add(UpdateUserEvent(
          newUser.copyWith(accessToken: authbloc.user.accessToken)));
      emit(ProfileInitial());
    });
  }

  // set weight target
  Future<void> setWeightTarget(double weightTarget) async {
    final result = await goalsRepository.setWeightTarget(weightTarget);
    result.fold((l) => emit(ProfileError(message: l.message)), (newGoals) {
      userGoals.targetWeight = newGoals.targetWeight;
      emit(ProfileInitial());
    });
  }

  // set steps target
  Future<void> setStepsTarget(int stepsTarget) async {
    final result = await goalsRepository.setStepsTarget(stepsTarget);
    result.fold((l) => emit(ProfileError(message: l.message)), (newGoals) {
      userGoals = newGoals;
      emit(ProfileInitial());
    });
  }

  // set calories target
  Future<void> setCaloriesTarget(int caloriesTarget) async {
    final result = await goalsRepository.setCaloriesTarget(caloriesTarget);
    result.fold((l) => emit(ProfileError(message: l.message)), (newGoals) {
      userGoals = newGoals;
      emit(ProfileInitial());
    });
  }

  void reset() {
    emit(ProfileInitial());
  } 

  // finish set goals
  Future<void> finishSetGoals() async {
    final result = await goalsRepository.finishSetGoals();
    result.fold((l) => emit(ProfileError(message: l.message)), (_) {
      authbloc.add(UpdateUserEvent(
          authbloc.user.copyWith(accessToken: authbloc.user.accessToken)));
      emit(ProfileInitial());
    });
  }

  // get user goals
  Future<void> getUserGoals() async {
    final result = await goalsRepository.getUserGoals();
    result.fold((l) => emit(ProfileError(message: l.message)), (goals) {
      userGoals = goals;
      emit(ProfileInitial());
    });
  }
}
