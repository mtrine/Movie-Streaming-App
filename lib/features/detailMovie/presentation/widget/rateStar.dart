import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/detail_film_bloc.dart';

class RateStar extends StatelessWidget {
  const RateStar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailFilmBloc,DetailFilmState>(
      builder: (context,state) {
        return Row(
          children: [
            Text(state.rate.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(Icons.star, color: Colors.yellow, size: 30,)
          ],
        );
      }
    );
  }
}