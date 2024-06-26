import 'package:movie_streaming_app/features/detailMovie/models/reviewMovie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReviewRepository {
  late final _supabase = Supabase.instance.client;

  Future<ReviewMovie?> getInfoFilm(String movie_id) async {
    try {
      final response = await _supabase
          .from('movies')
          .select(
          '*, '
              'reviews(*)')
          .eq('id', movie_id)
          .single();
      final reviewMovie = ReviewMovie.fromMap(response);
      return reviewMovie;
        } catch (e) {
      print('Error ReviewRepo: $e');
      return null;
    }
  }

  Future<void> addReview(String movieId, String review, int star) async {
    try {
      final timestamp = DateTime.now().toIso8601String();
      final response = await _supabase.from('reviews').insert([
        {
          'user_id': _supabase.auth.currentUser!.id,
          'movie_id': movieId,
          'review_text': review,
          'rating': star,
          'created_at': timestamp,
          'updated_at': timestamp,
        }
      ]);

      if (response.error != null) {
        throw Exception(response.error!.message);
      }
    } catch (e) {
      throw Exception('Error adding review: $e');
    }
  }
}