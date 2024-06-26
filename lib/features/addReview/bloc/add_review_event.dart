part of 'add_review_bloc.dart';

@immutable
abstract class AddReviewEvent {}

class SubmitReview extends AddReviewEvent {
  final String movieId;
  final String review;
  final int star;

  SubmitReview({required this.movieId, required this.review, required this.star});
}
