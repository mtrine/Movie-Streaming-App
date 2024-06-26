import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/movies_genres.dart';

class GenresReponsitory{
  late final  supabase = Supabase.instance.client;
  Future<List<MoviesGenres>?> getGenres() async {
    List<MoviesGenres> genres = [];
    try{
      final respone = await supabase.from('genres')
          .select('''
          name,
          movies(*)
      ''');
      print(respone[0]['movies']);
      respone.map((e)=> genres.add(MoviesGenres.fromMap(e))).toList();
      return genres;
    } catch (e) {
      print('Error:$e');
      return null;
    }
  }

}