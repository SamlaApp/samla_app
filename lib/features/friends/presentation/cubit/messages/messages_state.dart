part of 'messages_cubit.dart';



abstract class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object> get props => [];
}

class MessagesInitial extends MessagesState {}

class MessagesLoading extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final List<Message> messages;

  MessagesLoaded({required this.messages});

  @override
  List<Object> get props => [messages];
}

class MessagesError extends MessagesState {
  final String message;

  MessagesError({required this.message});

  @override
  List<Object> get props => [message];
}

// class MessagesLoadedList extends FetchMessagesState {
//   final List<MessageModel> messages;

//   const MessagesLoadedList({required this.messages});

//   @override
//   List<Object> get props => [messages];
// }

// class MessagesLoadedListCheck extends FetchMessagesState {
//   final List<MessageModel> messages;

//   const MessagesLoadedListCheck({required this.messages});

//   @override
//   List<Object> get props => [messages];
// }
