import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/community/data/models/RequestToJoin.dart';
import 'package:samla_app/features/community/domain/repositories/community_admin_repository.dart';

part 'requests_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit(this._communityAdminRepository)
      : super(RequestsCubitsInitial());
  final CommunityAdminRepository _communityAdminRepository;

  Future<void> getJoinRequests(int communityID) async {
    emit(RequestsCubitsLoading());
    final result = await _communityAdminRepository.getJoinRequests(
        communityID: communityID);
    result.fold(
      (failure) => emit(RequestsCubitsError(failure.message)),
      (requests) => emit(RequestsCubitsLoaded(requests)),
    );
  }

  Future<void> acceptRequest(RequestToJoin request) async {
    // emit(RequestsCubitsLoading());
    // final result = await _communityAdminRepository.acceptRequest(request);
    // result.fold(
    //   (failure) => emit(RequestsCubitsError(failure.message)),
    //   (_) => emit(RequestsCubitsInitial()),
    // );
  }

  Future<void> rejectRequest(RequestToJoin request) async {
    // emit(RequestsCubitsLoading());
    // final result = await _communityAdminRepository.rejectRequest(request);
    // result.fold(
    //   (failure) => emit(RequestsCubitsError(failure.message)),
    //   (_) => emit(RequestsCubitsInitial()),
    // );
  }
}
