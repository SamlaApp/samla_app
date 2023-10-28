import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart';
import 'package:samla_app/features/community/domain/repositories/community_repository.dart';

part 'create_community_state.dart';

class CreateCommunityCubit extends Cubit<CreateCommunityState> {
  CreateCommunityCubit(this.repository) : super(CreateCommunityInitial());
  final CommunityRepository repository;

  Future<void> createCommunity(Community community) async {
    emit(CreateLoadingState()); // Show loading state
    final result = await repository.createCommunity(community: community);
    result.fold(
      (failure) => emit(CreateErrorState('Failed to create community')),
      (cretedCommunity) => emit(CreatedSuccessfullyState(
          cretedCommunity)), // Refresh the list of communities
    );
  }
}
