import 'package:supabase_flutter/supabase_flutter.dart';

import '../../home/models/movies.dart';

class WatchedListRepository{
  late final supabase = Supabase.instance.client;
  Future<void> addWatchedList(String movieId) async {
    try{
      final user = supabase.auth.currentUser;
      await supabase.from('watchlist').insert({
        'user_id': user!.id,
        'movie_id': movieId,
        'added_at': DateTime.now().toIso8601String(),
      });
    }
    catch(e){
      print('Error WatchedListRepository: $e');
    }
  }
  Future<List<Movies>?> getWatchedList() async {
    List<Movies>? listWatchedMovie=[];
    try{
      final user = supabase.auth.currentUser;
      final response = await supabase
          .from('watchlist')
          .select("movies:movie_id(*)")
          .eq('user_id', user!.id);
      response.forEach((e)=> listWatchedMovie.add(Movies.fromMap(e['movies'])));
      print('listWatchedMovie: $listWatchedMovie');
      return listWatchedMovie;
    }
    catch(e){
      print('Error WatchedListRepository: $e');
    }
  }
}