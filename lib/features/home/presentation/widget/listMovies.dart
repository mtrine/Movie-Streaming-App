import 'package:flutter/material.dart';

import '../../../detailMovie/presentation/screens/detailFilm.dart';
import '../../models/movies.dart';

class ListMoviesByGenre extends StatelessWidget {
  const ListMoviesByGenre({
    super.key,

    required this.title,
    required this.listMovies,
  });
  final String title;
  final List<Movies> listMovies;
  @override
  Widget build(BuildContext context) {
    void detailPage(String movieId) {
      Navigator.pushNamed(
        context,
        DetailFilm.routeName,
        arguments: movieId,
      );
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: listMovies.isEmpty
                  ?const Center(
                child: Text(
                    'No data',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                )
            )
                  :ListView(
              scrollDirection: Axis.horizontal,
              children: listMovies.map((movie) {
                return GestureDetector(
                  onTap: () => detailPage(movie.id!),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(movie.posterImg!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
