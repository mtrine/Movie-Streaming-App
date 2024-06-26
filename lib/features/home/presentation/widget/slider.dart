import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:movie_streaming_app/features/home/presentation/widget/poster_film.dart';
import '../../models/movies.dart';
import 'NameAndDescription.dart';

class SliderSwiper extends StatelessWidget {
  const SliderSwiper({
    super.key,
    required this.size,
    required this.movies,
  });
  final Size size;
  final List<Movies> movies ;

  @override
  Widget build(BuildContext context) {
    detailPage(String movieId) {
      Navigator.pushNamed(context, '/detailFilm',arguments: movieId);
    }
    return Swiper(
      itemCount: movies.length>5?5:movies.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap:()=> detailPage(movies[index].id!),
          child: Stack(
            children: [
              PosterFilm(url: movies[index].posterImg!,),
              Container(
                color: Colors.black.withOpacity(0.5), // Dark overlay color with opacity
                height: size.height * 0.7,
                width: size.width,),
                 NameAndDescriptionOnSlide(
                     name: movies[index].title,
                     description:movies[index].description
                 ),
            ],
          ),
        );
      },
      pagination: const SwiperPagination(),
      autoplay: true, // Enable autoplay
      autoplayDelay: 3000, // Delay between automatic swipes in milliseconds
      autoplayDisableOnInteraction: true,
    );
  }
}

