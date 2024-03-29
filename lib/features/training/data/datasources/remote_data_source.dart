import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/features/training/data/models/ExerciseDay_model.dart';
import 'package:samla_app/features/training/data/models/ExerciseHistory_model.dart';
import 'package:samla_app/features/training/data/models/exerciseLibrary_model.dart';
import 'package:samla_app/features/training/data/models/template_model.dart';
import 'package:http/http.dart' as http;
import 'package:samla_app/core/network/samlaAPI.dart';
import 'package:samla_app/features/training/domain/entities/ExerciseDay.dart';
import 'package:samla_app/features/training/domain/entities/ExerciseHistory.dart';
import 'package:samla_app/features/training/domain/entities/ExerciseLibrary.dart';
import 'package:samla_app/features/training/domain/entities/Template.dart';

abstract class RemoteDataSource {
  Future<List<Template>> getAllTemplates();

  Future<Template> createTemplate(Template template);

  Future<Template> activeTemplate();

  Future<void> deleteTemplate(int id);

  Future<List<ExerciseLibrary>> getBodyPartExerciseLibrary(
      {required String part, required int templateID});

  Future<ExerciseDay> addExerciseToPlan(ExerciseDay exerciseDay);

  Future<Template> getTemplateDetails(int id);

  Future<Template> updateTemplateDaysName(Template template);

  Future<List<ExerciseLibrary>> getExercisesDay(
      {required String day, required int templateID});

  Future<Template> updateTemplateInfo(Template template);

  Future<void> removeExerciseFromPlan(
      {required int exerciseID, required String day, required int templateID});

  Future<List<ExerciseHistory>> getHistory(int id);

  Future<Unit> addHistory(
      {required int set,
      required int duration,
      required int repetitions,
      required double weight,
      required double distance,
      required String notes,
      required int exercise_library_id});
}

class TemplateRemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  TemplateRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Template>> getAllTemplates() async {
    final res =
        await samlaAPI(endPoint: '/training/template/get', method: 'GET');
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      final List<dynamic> templates = json.decode(resBody)['templates'];
      final List<TemplateModel> convertedTemplates = templates
          .map((e) => TemplateModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return convertedTemplates;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<Template> createTemplate(Template template) async {
    final n_template = TemplateModel.fromEntity(template);
    final res = await samlaAPI(
        endPoint: '/training/template/create',
        method: 'POST',
        data: n_template.toJson());
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      final TemplateModel convertedTemplate =
          TemplateModel.fromJson(json.decode(resBody)['template']);
      return convertedTemplate;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<Template> activeTemplate() async {
    final res =
        await samlaAPI(endPoint: '/training/template/active', method: 'GET');
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      final TemplateModel convertedTemplate =
          TemplateModel.fromJson(json.decode(resBody)['template']);
      return convertedTemplate;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<void> deleteTemplate(int id) async {
    final res = await samlaAPI(
        data: {'id': id.toString()},
        endPoint: '/training/template/delete',
        method: 'POST');
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      return Future.value();
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<List<ExerciseLibrary>> getBodyPartExerciseLibrary(
      {required String part, required int templateID}) async {
    final res = await samlaAPI(
        endPoint: '/training/exercise/get/$part/$templateID', method: 'GET');
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      final List<dynamic> exercises = json.decode(resBody)['exercises'];
      final List<ExerciseLibraryModel> convertedExercises = exercises
          .map((e) => ExerciseLibraryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return convertedExercises;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<ExerciseDay> addExerciseToPlan(ExerciseDay exerciseDay) async {
    final n_exerciseDay = ExerciseDayModel.fromEntity(exerciseDay);
    final res = await samlaAPI(
        endPoint: '/training/exercise/plan/add',
        method: 'POST',
        data: n_exerciseDay.toJson());
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 201) {
      final ExerciseDayModel convertedExerciseDay =
          ExerciseDayModel.fromJson(json.decode(resBody)['exercise_day']);
      return convertedExerciseDay;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<Template> getTemplateDetails(int id) async {
    final res =
        await samlaAPI(endPoint: '/training/template/get/$id', method: 'GET');
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      final TemplateModel convertedTemplate =
          TemplateModel.fromJson(json.decode(resBody)['template']);
      return convertedTemplate;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<Template> updateTemplateDaysName(Template template) async {
    final n_template = TemplateModel.fromEntity(template);
    final res = await samlaAPI(
        endPoint: '/training/plan/day/update',
        method: 'POST',
        data: n_template.toJson());
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      final TemplateModel convertedTemplate =
          TemplateModel.fromJson(json.decode(resBody)['template']);
      return convertedTemplate;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<List<ExerciseLibrary>> getExercisesDay(
      {required String day, required int templateID}) async {
    final res = await samlaAPI(
        endPoint: '/training/plan/get/$templateID/$day', method: 'GET');
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      final List<dynamic> exercises = json.decode(resBody)['exercises'];
      final List<ExerciseLibraryModel> convertedExercises = exercises
          .map((e) => ExerciseLibraryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return convertedExercises;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<Template> updateTemplateInfo(Template template) async {
    final n_template = TemplateModel.fromEntity(template);
    final res = await samlaAPI(
        endPoint: '/training/template/update',
        method: 'POST',
        data: n_template.toJson());
    final resBody = await res.stream.bytesToString();
    print(resBody);
    if (res.statusCode == 200) {
      final TemplateModel convertedTemplate =
          TemplateModel.fromJson(json.decode(resBody)['template']);
      return convertedTemplate;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<void> removeExerciseFromPlan(
      {required int exerciseID,
      required String day,
      required int templateID}) async {
    final res = await samlaAPI(data: {
      'exercise_library_id': exerciseID.toString(),
      'day': day,
      'exercise_template_id': templateID.toString()
    }, endPoint: '/training/exercise/plan/remove', method: 'POST');
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      return Future.value();
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<List<ExerciseHistory>> getHistory(int id) async {
    final res =
        await samlaAPI(endPoint: '/training/history/get/$id', method: 'GET');
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      final List<dynamic> history = json.decode(resBody)['exercise_history'];
      final List<ExerciseHistoryModel> convertedHistory = history
          .map((e) => ExerciseHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return convertedHistory;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

  @override
  Future<Unit> addHistory(
      {required int set,
      required int duration,
      required int repetitions,
      required double weight,
      required double distance,
      required String notes,
      required int exercise_library_id}) async {
    final res = await samlaAPI(data: {
      'sets': set.toString(),
      'duration': duration.toString(),
      'repetitions': repetitions.toString(),
      'weight': weight.toString(),
      'distance': distance.toString(),
      'notes': notes,
      'exercise_library_id': exercise_library_id.toString()
    }, endPoint: '/training/history/set', method: 'POST');
    final resBody = await res.stream.bytesToString();
    print(resBody);
    if (res.statusCode == 200) {
      return unit;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }
}
