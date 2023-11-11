import 'package:samla_app/features/training/domain/entities/Template.dart';

class TemplateModel extends Template {
  const TemplateModel({
    required super.id,
    required super.name,
    required super.is_active,
  });

  @override
  factory TemplateModel.fromJson(Map<String, dynamic> json) {
    return TemplateModel(
      id: json['id'],
      name: json['name'],
      is_active: json['is_active'] == 1 ? true : false,
    );
  }

  Map<String, String> toJson() {
    return {
      'id': id.toString(),
      'name': name,
      'is_active': is_active ? '1' : '0',
    };
  }

  factory TemplateModel.fromEntity(Template entity) {
    return TemplateModel(
      id: entity.id,
      name: entity.name,
      is_active: entity.is_active,
    );
  }

}