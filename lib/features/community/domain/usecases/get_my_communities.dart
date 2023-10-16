import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart';
import 'package:samla_app/features/community/domain/repositories/community_repository.dart';

class GetMyCommunities {
  final CommunityRepository _communityRepository;

  GetMyCommunities(this._communityRepository);

  Future<Either<Failure, List<Community>>> call() async {
    return await _communityRepository.getMyCommunities();
  }
}
