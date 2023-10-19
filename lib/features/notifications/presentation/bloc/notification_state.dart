part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationLoadedState extends NotificationState {
  final List<Notification_> notifications;

  NotificationLoadedState({required this.notifications});

  @override
  List<Object> get props => [notifications];
}

class NotificationErrorState extends NotificationState {
  final String message;

  NotificationErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
