import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_streaming_app/core/constants/app_color.dart';
import 'package:movie_streaming_app/features/detailMovie/presentation/widget/description_detail_film.dart';
import 'package:movie_streaming_app/features/home/presentation/widget/poster_film.dart';
import '../../../../core/widget/appBar.dart';
import '../../bloc/detail_film_bloc.dart';
import '../../repository/genreRepository.dart';
import '../../repository/reviewRepository.dart';
import '../../repository/watched_list_repository.dart';
import '../widget/name_and_rate.dart';

class DetailFilm extends StatefulWidget {
  const DetailFilm({super.key, required this.movieId});
  static const String routeName = '/detailFilm';
  final String movieId;
  @override
  State<DetailFilm> createState() => _DetailFilmState();
}

class _DetailFilmState extends State<DetailFilm> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  @override
  void initState() {
    _tabController=TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   final size= MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff0A071E),
      body: BlocProvider(
        create: (context) => DetailFilmBloc(
          reviewRepository: context.read<ReviewRepository>(),
          genreRepository:context.read<GenreRepository>(),
          watchedListRepository:WatchedListRepository()
        )..add(GetDetailFilm(widget.movieId)),
        child: SingleChildScrollView(
          child: BlocBuilder<DetailFilmBloc,DetailFilmState>(
            builder: (context,state) {
              if (state.status == DetailFilmStatus.loading) {
                return const Align(
                  alignment: Alignment.center,
                    child: Center(
                        child: CircularProgressIndicator()
                    )
                );
              }
              if (state.status == DetailFilmStatus.loaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        PosterFilm(url: state.movie.posterImg ?? ''),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black.withOpacity(0.4),
                        ),
                        const AppBarApp(),
                        const NameAndRate(),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height:size.height-120,
                      child:Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width:size.width,
                            child:TabBar(
                              tabs: const [
                                Tab(text: 'Infomation',),
                                Tab(text: 'Review',),
                              ],
                              controller: _tabController,
                              indicatorColor: Colors.white,
                              labelStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                              unselectedLabelStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal
                              ),
                              indicatorSize: TabBarIndicatorSize.label,
                            )
                          ),
                          const SizedBox(height: 10,),
                          Expanded(
                              child: TabBarView(
                                controller: _tabController,
                                children:  [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                  text: 'Genres:\n',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      fontWeight: FontWeight.bold
                                                  )
                                              ),
                                              TextSpan(
                                                  text: state.genres.join(', '),
                                                  style: const TextStyle(
                                                      fontSize: 22,
                                                  )
                                              ),
                                            ]
                                          )
                                      ),
                                      const SizedBox(height: 10,),
                                      const DescriptionDetailFilm(),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: TextButton(
                                            onPressed: (){
                                              Navigator.pushNamed(context, '/addReview',arguments: widget.movieId);
                                            },
                                            child: const Text(
                                                'Add Review',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold
                                              )
                                            )
                                        ),
                                      ),
                                     ListView.builder(
                                       shrinkWrap: true,
                                       itemCount: state.listReview.length,
                                       itemBuilder: (context,index) {
                                         return  Container(
                                            margin: const EdgeInsets.only(bottom: 20),
                                           decoration: BoxDecoration(
                                                color: AppColors.darkPurpleColor,
                                                borderRadius: BorderRadius.circular(10)
                                           ),
                                           child: Column(
                                             mainAxisSize: MainAxisSize.min,
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Row(
                                                 children:[
                                                   const Icon(Icons.star, color: Colors.yellow, size: 30,),
                                                   Text('${state.listReview[index].rating}/5',style: const TextStyle(
                                                     color: Colors.white,
                                                     fontSize: 24,
                                                     fontWeight: FontWeight.bold,
                                                   ),
                                                   )
                                                 ]
                                               ),
                                               const SizedBox(height: 10,),
                                               Text(state.listReview[index].review!,style: const TextStyle(
                                                 color: Colors.white,
                                                 fontSize: 25,
                                               ),
                                               ),
                                             ],
                                           ),
                                         );
                                       }
                                     )
                                    ],
                                  )
                                ],
                              )
                          )
                        ],
                      )

                    )

                  ],
                );
              }
              return const Center(child: Text('Error'));
            }
          ),
        ),
      ),
    );
  }
}
