import 'package:supabase_flutter/supabase_flutter.dart';

class GenreRepository{
  late final supabase = Supabase.instance.client;
  Future<List<String>> getGenresByMovieId(String movieId) async {
    List<String> genres = [];
    try {
      final response = await supabase.from('movies').select(
          'genres(name)'
      ).eq('id', movieId);
      response[0]['genres'].forEach((element) {
        String genre = element['name'].trim();
        genres.add(genre);
      });
      return genres;
    } catch (e) {
      print('Error getGenres: $e');
      return [];
    }
  }
}