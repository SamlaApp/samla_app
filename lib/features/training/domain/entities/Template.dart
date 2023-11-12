import 'package:equatable/equatable.dart';

class Template extends Equatable {
  final int? id;
  final String name;
  final bool is_active;

  const Template({
    this.id,
    required this.name,
    required this.is_active,
  });

  @override
  List<Object?> get props => [id, name, is_active];

  Template copyWith({
    int? id,
    String? name,
    bool? is_active,
  }) {
    return Template(
      id: id ?? this.id,
      name: name ?? this.name,
      is_active: is_active ?? this.is_active,
    );
  }
}
