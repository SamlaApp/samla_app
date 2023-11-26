import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart';
import 'package:samla_app/features/auth/domain/entities/user.dart';
import 'package:samla_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:samla_app/features/profile/data/goals_repository.dart';
import 'package:samla_app/features/profile/domain/Goals.dart';
import 'package:samla_app/features/profile/presentation/widgets/SettingsWidget.dart';
import 'package:http/http.dart' as http;

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
      emit(UserGoalloaded(userGoal: userGoals));
    });
  }

  // set height
  Future<void> setHeight(double height) async {
    emit(ProfileLoading());
    final result = await goalsRepository.setHeight(height);
    result.fold((l) => emit(ProfileError(message: l.message)), (newUser) {
      authbloc.add(UpdateUserEvent(
          newUser.copyWith(accessToken: authbloc.user.accessToken)));
      emit(UserGoalloaded(userGoal: userGoals));
    });
  }

  // set weight target
  Future<void> setWeightTarget(double weightTarget) async {
    emit(ProfileLoading());
    final result = await goalsRepository.setWeightTarget(weightTarget);
    result.fold((l) => emit(ProfileError(message: l.message)), (newGoals) {
      userGoals.targetWeight = newGoals.targetWeight;
      emit(UserGoalloaded(userGoal: userGoals));
    });
  }

  // set steps target
  Future<void> setStepsTarget(int stepsTarget) async {
    emit(ProfileLoading());

    final result = await goalsRepository.setStepsTarget(stepsTarget);
    result.fold((l) => emit(ProfileError(message: l.message)), (newGoals) {
      userGoals = newGoals;
      emit(UserGoalloaded(userGoal: userGoals));
    });
  }

  // set calories target
  Future<void> setCaloriesTarget(int caloriesTarget) async {
    emit(ProfileLoading());

    final result = await goalsRepository.setCaloriesTarget(caloriesTarget);
    result.fold((l) => emit(ProfileError(message: l.message)), (newGoals) {
      userGoals = newGoals;
      emit(UserGoalloaded(userGoal: userGoals));
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
      emit(UserGoalloaded(userGoal: userGoals));
    });
  }

  Future<void> getGoal() async {
    emit(ProfileLoading()); // Show loading state
    final result = await goalsRepository.getUserGoals();
    result.fold(
        (failure) =>
            emit(UserGoalErrorState(message: 'Failed loaded user profile')),
        (userGoal) {
      emit(UserGoalloaded(userGoal: userGoal));
    });
  }

  Future<void> updateAvatar(File image) async {
    emit(ProfileAvatarLoading()); // Show loading state
    final result = await goalsRepository.updateAvatar(image);
    result.fold(
        (failure) =>
            emit(UserAvatarErrorState(message: 'Failed loaded user profile')),
        (user) {
          authbloc.add(UpdateUserEvent(user.copyWith(accessToken: authbloc.user.accessToken)));
          emit(UserAvatarLoaded(imageFile: image));
    });
  }

  Future<void> updateUserSetting(User user) async {
    emit(UserSettingLoading()); // Show loading state
    final result = await goalsRepository.updateUserSetting(user);
    result.fold(
            (failure) =>
            emit(UpdateUserSettingState(message: 'Failed loaded user profile')),
            (user) {
          authbloc.add(UpdateUserEvent(user.copyWith(accessToken: authbloc.user.accessToken)));
          emit(UpdateUserSettingLoaded(user: user));
        });
  }


  Future<void> updatePassword(String newPassword, String confirmPassword) async {
    emit(UpdatePasswordLoading());

    if (newPassword != confirmPassword) {
      emit(UpdatePasswordErrorState(message: 'Passwords do not match'));
      return;
    }
    final result = await goalsRepository.updatePassword(newPassword,confirmPassword);
    result.fold(
          (failure) => emit(UpdatePasswordErrorState(message: failure.message)),
          (_) => emit(UpdatePasswordSuccess()),
    );
  }

  void Function()? onAccountDeactivated;
  Future<void> deleteUser() async {
print(user);
    try {
      // Make a DELETE request to the API endpoint
      final response = await http.delete(
        Uri.parse('https://samla.mohsowa.com/api/user/delete'),
        headers: {
          'Authorization': 'Bearer ${user.accessToken}', // Include your authentication token if required
        },
      );

      print(response.body);

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Handle success, maybe navigate to the login screen
        onAccountDeactivated?.call();
      } else {
        // Handle errors, you might want to show an error message
      }
    } catch (error) {
      // Handle exceptions, e.g., network errors
    }
  }


}
