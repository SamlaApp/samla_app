import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/core/error/failures.dart';
import 'package:samla_app/core/network/network_info.dart';

import 'package:samla_app/features/training/data/datasources/local_data_source.dart';
import 'package:samla_app/features/training/data/datasources/remote_data_source.dart';
import 'package:samla_app/features/training/data/models/template_model.dart';

import 'package:samla_app/features/training/domain/entities/Template.dart';

import 'package:samla_app/features/training/domain/repositories/template_repository.dart';

class TemplateRepositoryImpl implements TemplateRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TemplateRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Template>>> getAllTemplates() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTemplates = await remoteDataSource.getAllTemplates();
        localDataSource.cacheTemplates(remoteTemplates as List<TemplateModel>);
        return Right(remoteTemplates);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localTemplates = await localDataSource.getCachedTemplates();
        return Right(localTemplates);
      } on EmptyCacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Template>> createTemplate(Template template) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTemplate = await remoteDataSource.createTemplate(template);
        localDataSource.cacheTemplate(remoteTemplate as TemplateModel);
        return Right(remoteTemplate);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localTemplate = await localDataSource.getCachedTemplate(template.id as String);
        return Right(localTemplate);
      } on EmptyCacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Template>> activeTemplate() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTemplate = await remoteDataSource.activeTemplate();
        localDataSource.cacheTemplate(remoteTemplate as TemplateModel);
        return Right(remoteTemplate);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localTemplate = await localDataSource.getCachedActiveTemplate();
        return Right(localTemplate);
      } on EmptyCacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTemplate(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteTemplate(id);
        return Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        await localDataSource.deleteTemplate(id);
        return Right(unit);
      } on EmptyCacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Template>> getTemplateDetails(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTemplate = await remoteDataSource.getTemplateDetails(id);
        localDataSource.cacheTemplate(remoteTemplate as TemplateModel);
        return Right(remoteTemplate);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localTemplate = await localDataSource.getCachedTemplate(id.toString());
        return Right(localTemplate);
      } on EmptyCacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Template>> updateTemplateDaysName(Template template) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTemplate = await remoteDataSource.updateTemplateDaysName(template);
        localDataSource.cacheTemplate(remoteTemplate as TemplateModel);
        return Right(remoteTemplate);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      try {
        final localTemplate = await localDataSource.getCachedTemplate(template.id as String);
        return Right(localTemplate);
      } on EmptyCacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }
}