import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/failures.dart';

import 'package:samla_app/features/training/domain/entities/Template.dart';

abstract class TemplateRepository {
  Future<Either<Failure, List<Template>>> getAllTemplates();
  Future<Either<Failure, Template>> createTemplate(Template template);
  Future<Either<Failure, Template>> activeTemplate();
  Future<Either<Failure, Unit>> deleteTemplate(int id);
  Future<Either<Failure, Template>> getTemplateDetails(int id);
  Future<Either<Failure, Template>> updateTemplateDaysName(Template template);
}
