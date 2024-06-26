part of 'detail_film_bloc.dart';

@immutable
sealed class DetailFilmEvent {}

class GetDetailFilm extends DetailFilmEvent {
  final String id;
  GetDetailFilm(this.id);
}
class AddToWatchList extends DetailFilmEvent {
  final String movieId;
  AddToWatchList( this.movieId);
}