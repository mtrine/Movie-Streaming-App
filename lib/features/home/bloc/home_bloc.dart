import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/movies.dart';
import '../models/movies_genres.dart';
import '../reponsitory/genresReponsitory.dart';
import '../reponsitory/moviesReponsitory.dart';





part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final  GenresReponsitory _genresreponsitory;
  final MoviesReponsitory _moviesReponsitory;
  HomeBloc( this._genresreponsitory,this._moviesReponsitory) : super(HomeInitial()) {
    on<LoadHomeEvent>(_onLoadHome);
  }
  _onLoadHome(
    LoadHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final genresFuture =_genresreponsitory.getGenres();
      final movieFuture = _moviesReponsitory.getMovies();
      final response = await Future.wait([
        genresFuture,
        movieFuture
      ]);

      final genres = response[0] as List<MoviesGenres>;
      final movies = response[1] as List<Movies>;
      emit(
        state.copyWith(
          status: HomeStatus.loaded,
          listMoviesGenres: genres,
          listMovies: movies,
        ),
      );
    } catch (e) {

      emit(state.copyWith(status: HomeStatus.error));
    }
  }
}

