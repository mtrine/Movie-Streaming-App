import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../detailMovie/repository/reviewRepository.dart';

part 'add_review_event.dart';
part 'add_review_state.dart';

class AddReviewBloc extends Bloc<AddReviewEvent, AddReviewState> {
  final ReviewRepository _reviewRepository;

  AddReviewBloc(this._reviewRepository) : super(AddReviewInitial()) {
    on<SubmitReview>(_onSubmitReview);
  }

  Future<void> _onSubmitReview(SubmitReview event, Emitter<AddReviewState> emit) async {
    emit(state.copyWith(status: AddReviewStatus.loading));
    try {
      await _reviewRepository.addReview(event.movieId, event.review, event.star);
      emit(state.copyWith(status: AddReviewStatus.loaded));
    } catch (e) {
      emit(state.copyWith(status: AddReviewStatus.error, errorMessage: e.toString()));
    }
  }
}
