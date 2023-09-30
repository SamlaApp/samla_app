import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chatting_state.dart';

class ChattingCubit extends Cubit<ChattingState> {
  ChattingCubit() : super(ChattingInitial());
}
