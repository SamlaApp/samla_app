import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/community/domain/repositories/community_repository.dart';

class JoinCommunity{
  final CommunityRepository _communityRepository;

  JoinCommunity(this._communityRepository);

  Future<Either<Failure, Unit>> call({required int communityID}) async {
    return await _communityRepository.joinCommunity(communityID: communityID);
  }
}