import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/movies.dart';

class MoviesReponsitory{
  late final  supabase = Supabase.instance.client;
  Future<List<Movies>?> getMovies() async {
    List<Movies> listMovies = [];
    try{
      final response = await supabase.from('movies').select();
      response.map((e) => listMovies.add(Movies.fromMap(e))).toList();
      return listMovies;
    }
    catch(e){
      print("MoviesReponsitory"+e.toString());
      return null;
    }
  }
}