import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart';
import 'package:samla_app/features/community/domain/repositories/community_repository.dart';

part 'community_state.dart';

class CommunityCubit extends Cubit<CommunityState> {
  final CommunityRepository repository;
  List<Community> allCommunities = [];
  List<Community> myCommunities = [];

  CommunityCubit(this.repository) : super(CommunityInitial());

  Future<void> getMyCommunities() async {
    emit(CommunityLoading()); // Show loading state
    final result = await repository.getMyCommunities();
    result
        .fold((failure) => emit(CommunityError('Failed to fetch communities')),
            (communities) {
      if (communities.isEmpty) {
        emit(CommunityEmpty());
      } else emit(CommunitiesLoaded(communities));
    });
  }

  Future<void> leaveCommunity(
      int communityID, Function([String? err]) callback) async {
    final result = await repository.leaveCommunity(communityID: communityID);
    result.fold((failure) {
      callback(failure.message);
    }, (_) {
      getMyCommunities();
      callback();
    }); // R
  }

  Future<void> deleteCommunity(int communityID, callback) async {
    final result = await repository.deleteCommunity(communityID: communityID);
    result.fold((failure) {
      callback(failure.message);
    }, (_) {
      getMyCommunities();
      callback();
    }); //
  }

  Future<void> updateCommunity(int communityID) async {
    final result = await repository.updateCommunity(communityID: communityID);
    result.fold(
      (failure) => emit(CommunityError('Failed to update community')),
      (_) => getMyCommunities(), // Refresh the list of communities
    );
  }
}
