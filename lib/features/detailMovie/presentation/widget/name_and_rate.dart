import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_streaming_app/features/detailMovie/presentation/widget/rateStar.dart';
import '../../bloc/detail_film_bloc.dart';

class NameAndRate extends StatelessWidget {
  const NameAndRate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      bottom: 10,
      child: BlocBuilder<DetailFilmBloc,DetailFilmState>(
        builder: (context,state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  state.movie.title ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  )
              ),
              IconButton(
                  onPressed: (){
                    context.read<DetailFilmBloc>().add(AddToWatchList(state.movie.id!));
                    print('Play video');
                    Navigator.pushNamed(
                      context,
                      '/videoPlayer',
                      arguments: {
                        'videoUrl': state.movie.videoUrl, // Tham số đầu tiên
                        'movieId': state.movie.id, // Tham số thứ hai (ví dụ)
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.play_circle_outline,
                    color: Colors.white,
                    size: 70,
                  )
              ),
              const SizedBox(height: 10),
              const RateStar()
            ],
          );
        }
      ),
    );
  }
}
