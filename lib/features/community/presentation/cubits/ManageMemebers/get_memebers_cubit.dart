import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/community/domain/repositories/community_admin_repository.dart';

part 'get_memebers_state.dart';

class GetMemebersCubit extends Cubit<GetMemebersState> {
  GetMemebersCubit(this._communityAdminRepository) : super(GetMemebersInitial());
  final CommunityAdminRepository _communityAdminRepository;

  getMemebers(int communityId) async {
    // emit(GetMemebersLoading());
    // final result = await _communityAdminRepository.getMemebers(communityId);
    // result.fold(
    //   (l) => emit(GetMemebersError(l.message)),
    //   (r) => emit(GetMemebersLoaded(r)),
    // );
  }
}
