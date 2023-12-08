part of 'messages_cubit.dart';

abstract class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object> get props => [];
}

class MessagesInitial extends MessagesState {}

class MessagesLoading extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final MessageModel message;

  MessagesLoaded({required this.message});

  @override
  List<Object> get props => [message];
}

class MessagesError extends MessagesState {
  final String message;

  MessagesError({required this.message});

  @override
  List<Object> get props => [message];
}

class MessagesLoadedList extends MessagesState {
  final List<MessageModel> messages;

  const MessagesLoadedList({required this.messages});

  @override
  List<Object> get props => [messages];
}

class MessagesLoadedListCheck extends MessagesState {
  final List<MessageModel> messages;

  const MessagesLoadedListCheck({required this.messages});

  @override
  List<Object> get props => [messages];
}
