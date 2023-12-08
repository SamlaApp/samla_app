import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/message_model.dart';
import '../../../domain/repositories/messages_repo.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  final MessageRepository repository;

  MessagesCubit(this.repository) : super(MessagesInitial());

  Future<void> sendMessage(
      {required int friend_id,
      required String message,
      required String type}) async {
    emit(MessagesLoading());
    final result = await repository.sendMessage(
        friend_id: friend_id, message: message, type: type);
    result.fold(
      (failure) => emit(MessagesError(message: failure.message)),
      (messages) => emit(MessagesLoadedList(messages: messages)),
    );
  }

  Future<void> getMessages({required int friend_id}) async {
    emit(MessagesLoading());
    final result = await repository.getMessages(friend_id: friend_id);
    result.fold(
      (failure) => emit(MessagesError(message: failure.message)),
      (messages) => emit(MessagesLoadedList(messages: messages)),
    );
  }
}
