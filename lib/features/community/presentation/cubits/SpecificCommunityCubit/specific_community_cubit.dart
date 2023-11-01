import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
      print(numOfMemebers);
      emit(SpecificCommunityNumberLoaded(numOfMemebers));
    });
  }
}
