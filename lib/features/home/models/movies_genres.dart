import 'movies.dart';

class MoviesGenres{
  late final List<Movies> movies;
  late final String name;

  MoviesGenres({required this.name, required this.movies});


  // Phương thức fromMap
  factory MoviesGenres.fromMap(Map<String, dynamic> map) {
    List<Movies> movies = [];
    map['movies'].map((e) => movies.add(Movies.fromMap(e))).toList();
    return MoviesGenres(
      movies: movies,
      name: map['name'],
    );
  }
}