import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart';
import 'package:samla_app/features/community/domain/repositories/community_repository.dart';

part 'specific_community_state.dart';

class SpecificCommunityCubit extends Cubit<SpecificCommunityState> {
  final CommunityRepository repository;
  SpecificCommunityCubit(this.repository) : super(SpecificCommunityInitial());
  

  Future<void> getCommunitynumOfMemebers(int communityID) async {
    emit(SpecificCommunityLoading()); // Show loading state
    final failureOrDone =
        await repository.getCommunityMemebersNumber(communityID: communityID);
    failureOrDone.fold(
        (failure) =>
            emit(SpecificCommunityError('Failed to fetch community members')),
        (numOfMemebers) {
      emit(SpecificCommunityNumberLoaded(numOfMemebers));
    });
  }

  Future<void> updateCommunity(
      Community community, Function(Community) successCallback,
      {bool updateHandle = false}) async {
    final result = await repository.updateCommunity(community, updateHandle);
    result.fold(
        (failure) => emit(SpecificCommunityError('Failed to update community')),
        (community) {
      successCallback(community);
      final _state = state;
      emit(SpecificCommunityInitial());
      emit(_state);
    });
  }
}
