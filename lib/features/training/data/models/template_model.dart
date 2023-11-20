import 'package:samla_app/features/training/domain/entities/Template.dart';

class TemplateModel extends Template {
  const TemplateModel({
    required super.id,
    required super.name,
    required super.is_active,
    super.sunday,
    super.monday,
    super.tuesday,
    super.wednesday,
    super.thursday,
    super.friday,
    super.saturday,
  });

  @override
  factory TemplateModel.fromJson(Map<String, dynamic> json) {
    return TemplateModel(
      id: json['id'],
      name: json['name'],
      is_active: json['is_active'] == 1 ? true : false,
      sunday: json['sunday'],
      monday: json['monday'],
      tuesday: json['tuesday'],
      wednesday: json['wednesday'],
      thursday: json['thursday'],
      friday: json['friday'],
      saturday: json['saturday'],
    );
  }

  Map<String, String> toJson() {
    return {
      'id': id.toString(),
      'name': name,
      'is_active': is_active ? '1' : '0',
      'sunday': sunday ?? 'sunday',
      'monday': monday ?? 'monday',
      'tuesday': tuesday ?? 'tuesday',
      'wednesday': wednesday ?? 'wednesday',
      'thursday': thursday ?? 'thursday',
      'friday': friday ?? 'friday',
      'saturday': saturday ?? 'saturday',
    };
  }

  factory TemplateModel.fromEntity(Template entity) {
    return TemplateModel(
      id: entity.id,
      name: entity.name,
      is_active: entity.is_active,
      sunday: entity.sunday,
      monday: entity.monday,
      tuesday: entity.tuesday,
      wednesday: entity.wednesday,
      thursday: entity.thursday,
      friday: entity.friday,
      saturday: entity.saturday,
    );
  }

}