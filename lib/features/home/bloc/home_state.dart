part of 'home_bloc.dart';

enum HomeStatus { initial, loading, loaded, error }
@immutable
final class HomeState {
  const HomeState({
    this.status = HomeStatus.initial,
    this.listMovies = const <Movies>[],
    this.listMoviesGenres = const <MoviesGenres>[],
  });
  final HomeStatus status;
  final List<Movies> listMovies;
  final List<MoviesGenres> listMoviesGenres;

  HomeState copyWith({
    HomeStatus? status,
    List<Movies>? listMovies,
    List<MoviesGenres>? listMoviesGenres,
  }) {
    return HomeState(
      status: status ?? this.status,
      listMovies: listMovies ?? this.listMovies,
      listMoviesGenres: listMoviesGenres ?? this.listMoviesGenres,
    );
  }
}

final class HomeInitial extends HomeState {}
