import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/community/domain/repositories/community_repository.dart';

class LeaveCommunity {
  final CommunityRepository _communityRepository;

  LeaveCommunity(this._communityRepository);

  Future<Either<Failure, Unit>> call({required int communityID}) async {
    return await _communityRepository.leaveCommunity(communityID: communityID);
  }
}
