import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_posts_state.dart';

class GetPostsCubit extends Cubit<GetPostsState> {
  GetPostsCubit() : super(GetPostsInitial());

  
}
