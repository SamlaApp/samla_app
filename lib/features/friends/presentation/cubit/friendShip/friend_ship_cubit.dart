import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/friends/chat_di.dart';
import 'package:samla_app/features/friends/domain/entities/status.dart';
import 'package:samla_app/features/friends/domain/repositories/friend_repo.dart';

part 'friend_ship_state.dart';

class FriendShipCubit extends Cubit<FriendShipState> {
  final FriendRepository repository;
  FriendShipCubit(this.repository) : super(FriendShipInitial());

   Future<void> getStatus(int friendId) async {
    emit(const FriendShipLoading());
    final result = await sl<FriendRepository>().getFriendshipStatus(friendId);
    result.fold((l) {
      emit(FriendShipError(message:'could not detect user friendship'));
    }, (r) {
      emit(FriendShipLoaded(r));
    });
  }

}
