import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/notifications/domain/entities/notification.dart';
import 'package:samla_app/features/notifications/domain/usecases/get_notifications.dart';
import 'package:samla_app/features/notifications/domain/usecases/get_cached_notification.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotifications getNotifications;
  final GetCachedNotification getCachedNotification;
  late Notification notification;

  NotificationBloc({required this.getNotifications, required this.getCachedNotification})
      : super(NotificationInitial()) {
    //check cached notification

    on<NotificationEvent>((event, emit) async {

      // get notification
      if (event is GetNotificationEvent) {
        emit(NotificationLoadingState());
        final failuredOrDone = await getNotifications.call();

        failuredOrDone.fold((failure) {
          emit(NotificationErrorState(message: failure.message));
        }, (returnedNotification) {
          emit(NotificationLoadedState(notification: returnedNotification));
        });
      }

      // get cached notification
      else if (event is GetCachedNotificationEvent) {
        emit(NotificationLoadingState());
        final failuredOrDone = await getCachedNotification.call();

        failuredOrDone.fold((failure) {
          emit(NotificationErrorState(message: failure.message));
        }, (returnedNotification) {
          emit(NotificationLoadedState(notification: returnedNotification));
        });
      }
    });
  }
}
