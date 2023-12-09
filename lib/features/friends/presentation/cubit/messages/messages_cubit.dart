import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/features/friends/chat_di.dart';
import 'package:samla_app/features/friends/domain/entities/message.dart';
import 'package:samla_app/features/friends/domain/repositories/friend_repo.dart';
import '../../../domain/repositories/messages_repo.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  final MessageRepository repository;
  List<Message> messages = [];

  MessagesCubit(this.repository) : super(MessagesInitial());

  // Future<void> sendMessage(message) async {
  //   emit(MessagesLoading());
  //   final result = await repository.sendMessage(message);
  //   print(result);
  //   result.fold(
  //     (failure) => emit(MessagesError(message: failure.message)),
  //     (newMessages) {
  //       messages = newMessages;
  //       emit(MessagesLoaded(messages: newMessages));
  //     },
  //   );
  // }

  Future<void> sendMessage(
      {required int friend_id,
      required String message,
      required String type}) async {
    emit(MessagesLoading());
    final result = await repository.sendMessage(
        friend_id: friend_id, message: message, type: type);
    result.fold(
      (failure) => emit(MessagesError(message: failure.message)),
      (newMessages) {
        messages = newMessages;
        emit(MessagesLoaded(messages: newMessages));
      },
    );
  }

  Future<void> getMessages({required int friend_id}) async {
    emit(MessagesLoading());
    final result = await repository.getMessages(friend_id);
    result.fold(
      (failure) => emit(MessagesError(message: failure.message)),
      (newMessages) {
        messages = newMessages;
        emit(MessagesLoaded(messages: newMessages));
      },
    );
  }
}
