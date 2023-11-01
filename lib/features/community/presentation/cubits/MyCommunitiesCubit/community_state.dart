part of 'community_cubit.dart';

abstract class CommunityState extends Equatable {
  const CommunityState();

  @override
  List<Object> get props => [];
}

class CommunityLoading extends CommunityState {}

class CommunityInitial extends CommunityState {}

class CommunitiesLoaded extends CommunityState {
  final List<Community> communities;

  CommunitiesLoaded(this.communities);
}

class CommunityError extends CommunityState {
  final String message;

  CommunityError(this.message);
}


