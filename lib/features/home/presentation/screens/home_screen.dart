import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/constants.dart';
import '../../bloc/home_bloc.dart';
import '../../reponsitory/genresReponsitory.dart';
import '../../reponsitory/moviesReponsitory.dart';
import '../widget/listMovies.dart';
import '../../../../core/widget/avatar.dart';
import '../widget/slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => HomeBloc(
          context.read<GenresReponsitory>(), context.read<MoviesReponsitory>())
        ..add(LoadHomeEvent()),
      child: Scaffold(
        backgroundColor: const Color(0xff0A071E),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.status == HomeStatus.loading ||
                state.status == HomeStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == HomeStatus.loaded) {
              return ListView(
                children: [
                  SizedBox(
                    height: size.height * 0.7,
                    child: Stack(
                      children: [
                        SliderSwiper(
                          size: size,
                          movies: state.listMovies,
                        ),
                        const Padding(
                          padding: Constants.defaultPadding,
                          child: Row(
                            children: [
                              Spacer(),
                              Avatar(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...state.listMoviesGenres.map((genre) {
                    return ListMoviesByGenre(
                      title: genre.name,
                      listMovies: genre.movies,
                    );
                  }).toList(),
                ],
              );
            }
            return const Center(child: Text('Something went wrong!'));
          },
        ),
      ),
    );
  }
}




