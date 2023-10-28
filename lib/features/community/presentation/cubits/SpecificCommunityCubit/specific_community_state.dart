part of 'specific_community_cubit.dart';

sealed class SpecificCommunityState extends Equatable {
  const SpecificCommunityState();

  @override
  List<Object> get props => [];
}

final class SpecificCommunityInitial extends SpecificCommunityState {}

final class SpecificCommunityLoading extends SpecificCommunityState {}

final class SpecificCommunityNumberLoaded extends SpecificCommunityState {
  
  final int numOfMembers;

  SpecificCommunityNumberLoaded(this.numOfMembers);
}

final class SpecificCommunityError extends SpecificCommunityState {
  final String message;

  SpecificCommunityError(this.message);
}
