part of 'add_review_bloc.dart';

enum AddReviewStatus { initial, loading, loaded, error }

@immutable
class AddReviewState {
  final AddReviewStatus status;
  final String? errorMessage;

  const AddReviewState({this.status = AddReviewStatus.initial, this.errorMessage});

  AddReviewState copyWith({AddReviewStatus? status, String? errorMessage}) {
    return AddReviewState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}

class AddReviewInitial extends AddReviewState {}
