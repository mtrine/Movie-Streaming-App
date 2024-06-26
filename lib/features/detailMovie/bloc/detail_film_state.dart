part of 'detail_film_bloc.dart';

enum DetailFilmStatus { initial, loading, loaded,error}

@immutable
final class DetailFilmState {
  final Movies movie;
  final DetailFilmStatus status;
  final double rate;
  final List<Review> listReview;
  final List<String> genres;
  const DetailFilmState({
    this.status = DetailFilmStatus.initial,
    this.movie = const Movies(),
    this.rate = 0.0,
    this.listReview = const<Review> [],
    this.genres = const<String> [],
  });
  DetailFilmState copyWith({
    Movies? movie,
    DetailFilmStatus? status,
    double? rate,
    List<Review>? listReview,
    List<String>? genres,
  }) {
    return DetailFilmState(
      movie: movie ?? this.movie,
      status: status ?? this.status,
      rate: rate ?? this.rate,
      listReview: listReview ?? this.listReview,
      genres: genres ?? this.genres,
    );
  }

}

final class DetailFilmInitial extends DetailFilmState {}