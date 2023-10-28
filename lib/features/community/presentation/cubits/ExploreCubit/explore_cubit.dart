import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart';
import 'package:samla_app/features/community/domain/repositories/community_repository.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final CommunityRepository repository;
  ExploreCubit(this.repository) : super(ExploreInitial());

  Future<void> getAllCommunities() async {
    emit(ExploreLoading()); // Show loading state
    final result = await repository.getAllCommunities();
    result.fold((failure) => emit(ExploreError('Failed to fetch communities')),
        (communities) {
      if (communities.isEmpty) {
        print('empty');
        emit(ExploreEmpty());
        return;
      }
      emit(ExploreLoaded(communities));
    });
  }

  Future<void> joinCommunity(int communityID, Function([String? err]) callback) async {
    final result = await repository.joinCommunity(communityID: communityID);
    result.fold((failure) {
      callback(failure.message);
    }, (_) {
      getAllCommunities();
      callback();
    }); // Refresh the list of communities
  }
}
