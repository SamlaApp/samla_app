part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}
class ClearNotificationEvent extends NotificationEvent {}
class GetNotificationEvent extends NotificationEvent {}

class GetCachedNotificationEvent extends NotificationEvent {}
