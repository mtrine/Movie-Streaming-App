import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_streaming_app/features/home/models/movies.dart';

import '../../detailMovie/repository/watched_list_repository.dart';

part 'watched_list_event.dart';
part 'watched_list_state.dart';

class WatchedListBloc extends Bloc<WatchedListEvent, WatchedListState> {
  WatchedListRepository _watchedListRepository;
  WatchedListBloc(this._watchedListRepository) : super(WatchedListInitial()) {
    on<GetWatchedList>(_onGetWatchedList);
  }
  _onGetWatchedList(
      GetWatchedList event,
      Emitter<WatchedListState> emit)
      async {
        emit(state.copyWith(status: WatchedListStatus.loading));
        try{
          final listWatchedMovie = await _watchedListRepository.getWatchedList();
          emit(state.copyWith(status: WatchedListStatus.loaded, listWatchedMovie: listWatchedMovie));
        }
        catch(e){
          print('Error WatchedListBloc: $e');
          emit(state.copyWith(status: WatchedListStatus.error));
        }
      }
}
