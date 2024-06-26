import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_streaming_app/features/personal/bloc/watched_list_bloc.dart';

import '../../../../../core/constants/app_color.dart';
import '../../../../detailMovie/repository/watched_list_repository.dart';
import '../../../../home/models/movies.dart';
import '../../widget/watched_movie.dart';

class WatchList extends StatefulWidget {
  const WatchList({super.key});
  static const routeName = '/watchList';
  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff0A071E),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.whiteColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'My watched list',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.darkPurpleColor,
      ),
      body: BlocProvider(
        create:  (context) =>
            WatchedListBloc(
                context.read<WatchedListRepository>()
            )..add(GetWatchedList()),
        child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  color: AppColors.darkPurpleColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: BlocBuilder<WatchedListBloc,WatchedListState>(
                  builder: (context,state) {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Number of columns in the grid
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 20.0,
                        childAspectRatio: 0.75, // Adjust to your preference
                      ),
                      itemCount:  state.listWatchedMovie?.length ?? 0,
                      itemBuilder: (context, index) {
                        Movies? movies = state.listWatchedMovie?[index];
                        print('Movies: $movies');
                        return WatchedMovie(imageUrl: movies?.posterImg, title: movies?.title);
                      },
                    );
                  }
                ),
              ),
            ),
      )


    );
  }
}

