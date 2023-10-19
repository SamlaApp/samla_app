import 'package:equatable/equatable.dart';

class Notification_ extends Equatable {
  int? id;
  String title;
  String message;
  bool? isRead;
  String? createdAt;

  Notification_({
    this.id,
    required this.title,
    required this.message,
    this.isRead,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    message,
    isRead,
    createdAt,
  ];
}