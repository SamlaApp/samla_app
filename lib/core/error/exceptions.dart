class EmptyCacheException implements Exception {
  final String message;
  EmptyCacheException({this.message = 'Cache is empty'});
}
class ServerException implements Exception{
  final String message;
  ServerException({required this.message});
}
class OfflineException implements Exception{}

class UnauthorizedException implements Exception{}