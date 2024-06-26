import 'package:movie_streaming_app/features/detailMovie/models/review.dart';

import '../../home/models/movies.dart';

class ReviewMovie{
  late final Movies movie;
  late final List<Review> listReview;

  ReviewMovie({
    required this.movie,
    required this.listReview
  });

  factory ReviewMovie.fromMap(Map<String, dynamic> json) {
    List<Review> listReview = [];

    try {
      json['reviews']?.forEach((e) => listReview.add(Review.fromMap(e)));
      return ReviewMovie(
        movie: Movies.fromMap(json),
        listReview: listReview,
      );
    } catch (e) {
      print('Error ReviewMovie: $e');
      return ReviewMovie(movie: Movies(), listReview: []);
    }
  }
}