import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/community/domain/repositories/community_repository.dart';

class DeleteCommunity {
  final CommunityRepository _communityRepository;

  DeleteCommunity(this._communityRepository);

  Future<Either<Failure, Unit>> call({required int communityID}) async {
    return await _communityRepository.deleteCommunity(communityID: communityID);
  }
}
