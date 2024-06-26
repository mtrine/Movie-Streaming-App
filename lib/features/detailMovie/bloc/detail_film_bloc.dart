import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_streaming_app/features/home/models/movies.dart';
import '../models/review.dart';
import '../repository/genreRepository.dart';
import '../repository/reviewRepository.dart';
import '../repository/watched_list_repository.dart';

part 'detail_film_event.dart';
part 'detail_film_state.dart';

class DetailFilmBloc extends Bloc<DetailFilmEvent, DetailFilmState> {
  final ReviewRepository reviewRepository;
  final GenreRepository genreRepository ;
  WatchedListRepository? watchedListRepository;
  DetailFilmBloc(
      {required this.reviewRepository,
      required this.genreRepository,
      this.watchedListRepository}) : super(DetailFilmInitial()) {
    on< GetDetailFilm>(_onGetDetailFilm);
    on<AddToWatchList>(_onAddToWatchList);
  }
  _onGetDetailFilm(
      GetDetailFilm event,
    Emitter<DetailFilmState> emit,
      )async{
    emit(state.copyWith(status: DetailFilmStatus.loading));
    try{
      final movieReviews = reviewRepository.getInfoFilm(event.id);
      final genresMovie = genreRepository.getGenresByMovieId(event.id);
      final response = await Future.wait([
        movieReviews,
      ]);
      final response1 = await Future.wait([
        genresMovie,
      ]);
      final reviews = response[0]?.listReview;
      final movie = response[0]?.movie;
      final genres = response1[0];
      int sum=0;
      for (var element in reviews!) {
        sum+=element.rating!;
      }
      double rate=sum/reviews.length;
      emit(state.copyWith(
          status: DetailFilmStatus.loaded,
          listReview: reviews,
          movie: movie,
          rate: rate,
          genres: genres
      ));
    }
    catch(e){
      print('Error DetailFilmBLoc: $e');
      emit(state.copyWith(status: DetailFilmStatus.error));
    }
  }
  _onAddToWatchList(
      AddToWatchList event,
      Emitter<DetailFilmState> emit,
      )async{
    emit(state.copyWith(status: DetailFilmStatus.loading));
    try{
      await watchedListRepository?.addWatchedList(event.movieId);
      print('Add to watch list success');
      emit(state.copyWith(
          status: DetailFilmStatus.loaded,
      ));
    }
    catch(e){
      print('Error DetailFilmBLoc: $e');
      emit(state.copyWith(status: DetailFilmStatus.error));
    }
  }
}
