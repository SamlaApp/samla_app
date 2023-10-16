import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart';
import 'package:samla_app/features/community/domain/repositories/community_repository.dart';

class UpdateCommunity {
  final CommunityRepository _communityRepository;

  UpdateCommunity(this._communityRepository);

  Future<Either<Failure, Community>> call(
      {required int communityID}) async {
    return await _communityRepository.updateCommunity(communityID: communityID);
  }
}
