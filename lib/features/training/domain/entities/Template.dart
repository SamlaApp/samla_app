import 'package:equatable/equatable.dart';

class Template extends Equatable {
  final int? id;
  final String name;
  final bool is_active;
  final String? sunday;
  final String? monday;
  final String? tuesday;
  final String? wednesday;
  final String? thursday;
  final String? friday;
  final String? saturday;

  const Template({
    this.id,
    required this.name,
    required this.is_active,
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
  });

  @override
  List<Object?> get props => [id, name, is_active, sunday, monday, tuesday, wednesday, thursday, friday, saturday];

  Template copyWith({
    int? id,
    String? name,
    bool? is_active,
    String? sunday,
    String? monday,
    String? tuesday,
    String? wednesday,
    String? thursday,
    String? friday,
    String? saturday,
  }) {
    return Template(
      id: id ?? this.id,
      name: name ?? this.name,
      is_active: is_active ?? this.is_active,
      sunday: sunday ?? this.sunday,
      monday: monday ?? this.monday,
      tuesday: tuesday ?? this.tuesday,
      wednesday: wednesday ?? this.wednesday,
      thursday: thursday ?? this.thursday,
      friday: friday ?? this.friday,
      saturday: saturday ?? this.saturday,
    );
  }
}
