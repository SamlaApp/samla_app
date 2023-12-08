import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import '../../../../auth/data/models/user_model.dart';
import '../../../domain/repositories/explore_repo.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit(this.repository) : super(ExploreInitial());
  final ExploreRepository repository;

  // searchExplore
  Future<void> searchExplore(String query) async {
    emit(ExploreLoading());
    final result = await repository.searchExplore(query);
    result.fold((l) => emit(ExploreError(message: l.message)), (users) {
      if (users.isEmpty) {
        emit(ExploreEmpty());
        return;
      }
      emit(ExploreLoaded(users: users));
    });
  }
}
