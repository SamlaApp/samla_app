import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/notifications/domain/entities/notification.dart';
import 'package:samla_app/features/notifications/notification_injection_container.dart'
    as di;
import 'package:samla_app/features/notifications/presentation/bloc/notification_bloc.dart';

class NotificationsPage extends StatefulWidget {
  NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final notifiBloc = di.sl.get<NotificationBloc>();


  @override
  Widget build(BuildContext context) {

    notifiBloc.add(GetNotificationEvent());
    notifiBloc.add(GetCachedNotificationEvent());

    // return Scaffold NotificationWidget(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          centerTitle: true,
          backgroundColor: themeDarkBlue,
        ),
        body: BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {

              
          // state management is here

          // if lodaing state
          if (state is NotificationLoadingState) {
            return const Center(
              // shows loading indicator while state is Loading
              child: CircularProgressIndicator(),
            );
          }

          // if error state
          else if (state is NotificationErrorState) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
              notifiBloc.add(ClearNotificationEvent());
            });
          }

          // else return the widget
      
          List<Notification_> notifications = notifiBloc.notifications;
          notifications = notifications.reversed.toList(); // Reverse the list

          final now = DateTime.now();
          final yesterday = now.subtract(Duration(days: 1));
          final dateFormat = DateFormat.yMd().add_jm();


          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              final title = notification.title;
              final message = notification.message;
              var createdAt = notification.createdAt;

               // edit date format
              if (createdAt != null) {
                var date = DateTime.parse(createdAt);

                // Add 3 hours to the 'date' variable
                date = date.add(const Duration(hours: 3));

                if (date.year == now.year && date.month == now.month && date.day == now.day) {
                  // If it's today, only show the time
                  createdAt = DateFormat.jm().format(date);
                } else if (date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day) {
                  // If it's yesterday, display "Yesterday"
                  createdAt = "Yesterday";
                } else {
                  // For all other days, show the full date
                  createdAt = dateFormat.format(date);
                }
              }


              // Icon, title, message, date
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.notifications),
                  title: Text(title),
                  subtitle: Text(message),
                  trailing: Text(createdAt!, style: const TextStyle(color: Colors.grey)),
                ),
              );




            },
          );
        }));
  }
}
