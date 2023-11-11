import 'dart:convert';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/features/training/data/models/template_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class LocalDataSource {
  Future<void> cacheTemplates(List<TemplateModel> templates);
  Future<List<TemplateModel>> getCachedTemplates();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheTemplates(List<TemplateModel> templates) {
    final jsonTemplates = jsonEncode(templates);
    sharedPreferences.setString('my_templates', jsonTemplates);
    return Future.value();
  }

  @override
  Future<List<TemplateModel>> getCachedTemplates() {
    final jsonTemplatesString = sharedPreferences.getString('my_templates');
    if (jsonTemplatesString != null) {
      final jsonTemplatesList = json.decode(jsonTemplatesString);
      final templates = jsonTemplatesList
          .map<TemplateModel>((template) => TemplateModel.fromJson(template))
          .toList();
      return Future.value(templates);
    } else {
      throw EmptyCacheException(message: 'No cached templates');
    }
  }
}