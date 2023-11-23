import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/core/network/network_info.dart';
import 'package:samla_app/features/training/data/datasources/local_data_source.dart';
import 'package:samla_app/features/training/data/datasources/remote_data_source.dart';
import 'package:samla_app/features/training/domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  HistoryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

}