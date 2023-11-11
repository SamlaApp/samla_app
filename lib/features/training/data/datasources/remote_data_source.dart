import 'dart:convert';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/features/training/data/models/template_model.dart';
import 'package:http/http.dart' as http;
import 'package:samla_app/core/network/samlaAPI.dart';
import 'package:samla_app/features/training/domain/entities/Template.dart';

abstract class RemoteDataSource {
  Future<List<Template>> getAllTemplates();

  Future<Template> createTemplate(Template template);
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


}
