import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message = 'Something went wrong';
  @override
  List<Object?> get props => [message];
}

class OfflineFailure extends Failure {
  @override
  final String message;

  OfflineFailure({this.message = 'No internet connection'});
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  final String message;
  ServerFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class EmptyCacheFailure extends Failure {
  final String message;
  EmptyCacheFailure({required this.message});
  @override
  List<Object?> get props => [message];
  }


