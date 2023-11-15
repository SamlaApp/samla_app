import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:samla_app/features/auth/domain/entities/user.dart';
import 'package:samla_app/features/community/domain/repositories/community_admin_repository.dart';
import 'package:samla_app/features/community/domain/repositories/community_repository.dart';

part 'get_memebers_state.dart';

class MemebersCubit extends Cubit<MemebersState> {
  MemebersCubit(this._communityRepository, this._communityAdminRepository)
      : super(MemebersInitial());
  final CommunityRepository _communityRepository;
  final CommunityAdminRepository _communityAdminRepository;

  getMemebers(int communityId, bool isPublic) async {
    emit(MemebersLoading());
    final result =
        await _communityRepository.getCommunityMemebers(communityId, isPublic);
    result.fold(
      (l) => emit(MemebersError(l.message)),
      (r) => emit(MemebersLoaded(r)),
    );
  }

  deleteUser(int communityID, int userID, Function(String?) callbackFunction, isPublic) async {
    final result = await _communityAdminRepository.deleteUser(
        communityID: communityID, userID: userID);
    result.fold((l) {
      print(l.message);
      callbackFunction(l.message);
    }, (r) {
      getMemebers(communityID, isPublic);
      callbackFunction(null);
    });
  }
}
