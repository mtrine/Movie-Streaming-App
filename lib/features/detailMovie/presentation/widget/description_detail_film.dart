import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/detail_film_bloc.dart';

class DescriptionDetailFilm extends StatelessWidget {
  const DescriptionDetailFilm ({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          const Text(
              'Description',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )
          ),
          BlocBuilder<DetailFilmBloc,DetailFilmState>(
            builder: (context,state) {
              return SizedBox(
                width: MediaQuery.of(context).size.width - 20, // Adjust width as needed
                child: Text(
                  state.movie.description ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                  softWrap: true,

                ),
              );
            }
          ),
        ]
    );
  }
}
