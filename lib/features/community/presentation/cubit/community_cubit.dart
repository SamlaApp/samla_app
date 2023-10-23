import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart';
import 'package:samla_app/features/community/domain/repositories/community_repository.dart';

part 'community_state.dart';

class CommunityCubit extends Cubit<CommunityState> {
  final CommunityRepository repository;

  CommunityCubit(this.repository) : super(CommunityInitial());

  Future<void> getAllCommunities() async {
    emit(CommunityInitial()); // Show loading state
    final result = await repository.getAllCommunities();
    result.fold(
      (failure) => emit(CommunityError('Failed to fetch communities')),
      (communities) => emit(CommunitiesLoaded(communities)),
    );
  }

  Future<void> createCommunity(Community community) async {
    final result = await repository.createCommunity(community: community);
    result.fold(
      (failure) => emit(CommunityError('Failed to create community')),
      (_) => getAllCommunities(), // Refresh the list of communities
    );
  }

  Future<void> joinCommunity(int communityID) async {
    final result = await repository.joinCommunity(communityID: communityID);
    result.fold(
      (failure) => emit(CommunityError('Failed to join community')),
      (_) => getAllCommunities(), // Refresh the list of communities
    );
  }

  Future<void> leaveCommunity(int communityID) async {
    final result = await repository.leaveCommunity(communityID: communityID);
    result.fold(
      (failure) => emit(CommunityError('Failed to leave community')),
      (_) => getAllCommunities(), // Refresh the list of communities
    );
  }

  Future<void> deleteCommunity(int communityID) async {
    final result = await repository.deleteCommunity(communityID: communityID);
    result.fold(
      (failure) => emit(CommunityError('Failed to delete community')),
      (_) => getAllCommunities(), // Refresh the list of communities
    );
  }

  Future<void> updateCommunity(int communityID) async {
    final result = await repository.updateCommunity(communityID: communityID);
    result.fold(
      (failure) => emit(CommunityError('Failed to update community')),
      (_) => getAllCommunities(), // Refresh the list of communities
    );
  }
}
