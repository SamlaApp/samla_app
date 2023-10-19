part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationLoadedState extends NotificationState {
  final Notification notification;

  NotificationLoadedState({required this.notification});

  @override
  List<Object> get props => [notification];
}

class NotificationErrorState extends NotificationState {
  final String message;

  NotificationErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
