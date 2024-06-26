import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_streaming_app/core/constants/app_color.dart';
import '../../../detailMovie/bloc/detail_film_bloc.dart';
import '../../../detailMovie/repository/genreRepository.dart';
import '../../../detailMovie/repository/reviewRepository.dart';
import '../../bloc/add_review_bloc.dart';

class AddReviewScreen extends StatefulWidget {
  final String movieId;

  const AddReviewScreen({super.key, required this.movieId});
  static const String routeName = '/addReview';

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final TextEditingController _reviewController = TextEditingController();
  int _selectedStar = 0;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0A071E),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.whiteColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Viết đánh giá',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.darkPurpleColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => DetailFilmBloc(
                reviewRepository: context.read<ReviewRepository>(),
                genreRepository:context.read<GenreRepository>(),
              )..add(GetDetailFilm(widget.movieId)),
            ),
            BlocProvider(
              create: (context) => AddReviewBloc(context.read<ReviewRepository>()),
            ),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocConsumer<DetailFilmBloc, DetailFilmState>(
                listener: (context, state) {
                  if (state.status == DetailFilmStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Error loading movie details')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state.status == DetailFilmStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == DetailFilmStatus.loaded) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(state.movie.posterImg!),
                      ),
                      title: Text(
                        state.movie.title ?? '',
                        style: const TextStyle(color: AppColors.whiteColor, fontSize: 24),
                      ),
                      subtitle: Text(
                        state.genres.join(', '),
                        style: const TextStyle(color: AppColors.whiteColor, fontSize: 24),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Nhấn để đánh giá',
                style: TextStyle(fontSize: 16, color: AppColors.whiteColor),
              ),
              StarRating(
                selectedStar: _selectedStar,
                onStarSelected: (int index) {
                  setState(() {
                    _selectedStar = index + 1;
                  });
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Cảm nhận thêm về bộ phim',
                style: TextStyle(fontSize: 16, color: AppColors.whiteColor),
              ),
              TextField(
                controller: _reviewController,
                maxLines: 5,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Giờ là lúc ngôn từ lên ngôi ✍️',
                  hintStyle: TextStyle(color: AppColors.whiteColor),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: BlocConsumer<AddReviewBloc, AddReviewState>(
                  listener: (context, state) {
                    if (state.status == AddReviewStatus.loaded) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Đánh giá của bạn đã được gửi')),
                      );
                      Navigator.pop(context);
                    } else if (state.status == AddReviewStatus.error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error submitting review: ${state.errorMessage}')),
                      );
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (_selectedStar > 0 && _reviewController.text.isNotEmpty) {
                          context.read<AddReviewBloc>().add(SubmitReview(
                            movieId: widget.movieId,
                            star: _selectedStar,
                            review: _reviewController.text,
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please provide a rating and a review')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkPurpleColor,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Gửi đánh giá',
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 24,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int selectedStar;
  final ValueChanged<int> onStarSelected;

  const StarRating({Key? key, required this.selectedStar, required this.onStarSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < selectedStar ? Icons.star : Icons.star_border,
            color: index < selectedStar ? Colors.yellow : Colors.white,
          ),
          onPressed: () {
            onStarSelected(index);
          },
        );
      }),
    );
  }
}
