import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart';
import 'package:samla_app/features/community/domain/repositories/community_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final CommunityRepository repository;
  SearchCubit(this.repository) : super(SearchInitial());

  void search(String query) async {
    emit(SearchLoading());
    final result = await repository.searchCommunities(query);
    result.fold(
      (failure) => emit(SearchError(failure.message)),
      (communities) => emit(SearchLoaded(communities)),
    );
  }
}
