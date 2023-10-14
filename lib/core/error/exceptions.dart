class EmptyCacheException implements Exception {}
class ServerException implements Exception{
  final String message;
  ServerException({required this.message});
}
class OfflineException implements Exception{}