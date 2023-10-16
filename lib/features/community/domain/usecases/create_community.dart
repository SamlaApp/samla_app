import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart';
import 'package:samla_app/features/community/domain/repositories/community_repository.dart';

class CreateCommunity{
  final CommunityRepository _communityRepository;

  CreateCommunity(this._communityRepository);

  Future<Either<Failure,Community>> call( {required Community community}) async {
    return await _communityRepository.createCommunity(community:community);
  }
}