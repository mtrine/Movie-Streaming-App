part of 'watched_list_bloc.dart';

enum WatchedListStatus {
  initial,
  loading,
  loaded,
  error
}
@immutable
final class WatchedListState {
   WatchedListStatus? status;
  List<Movies>? listWatchedMovie;
  WatchedListState({
    this.status=WatchedListStatus.initial,
    this.listWatchedMovie=const []
  });
  WatchedListState copyWith({
    WatchedListStatus? status,
    List<Movies>? listWatchedMovie}
      ) {
    return WatchedListState(
      status: status ?? this.status,
      listWatchedMovie: listWatchedMovie ?? this.listWatchedMovie,
    );
  }
}

final class WatchedListInitial extends WatchedListState {}
