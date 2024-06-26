import 'package:flutter/cupertino.dart';
import 'package:movie_streaming_app/features/addReview/presentation/screens/add_review_screen.dart';
import 'package:movie_streaming_app/features/detailMovie/presentation/screens/detailFilm.dart';
import 'package:movie_streaming_app/features/home/presentation/screens/home_screen.dart';
import 'package:movie_streaming_app/features/personal/presentation/screens/personal.dart';
import 'package:movie_streaming_app/features/personal/presentation/screens/watchList/watch_list.dart';
import 'package:movie_streaming_app/features/videoPlay/presentation/screen/video_player_screen.dart';

import '../../features/auth/presentation/screens/create_account.dart';
import '../../features/auth/presentation/screens/login.dart';
import '../../main.dart';

class Routes{
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case WatchList.routeName:
        return _cupertinoRoute(const WatchList());
      case Login.routeName:
        return _cupertinoRoute(const Login());
      case Personal.routeName:
        return _cupertinoRoute(const Personal());
      case AddReviewScreen.routeName:
        final movieId = settings.arguments as String;
        return _cupertinoRoute(AddReviewScreen(movieId: movieId,));
      case VideoPlayerScreen.routeName:
        final Map<String, dynamic>? args = settings.arguments as Map<String, dynamic>?;
        final String videoUrl = args?['videoUrl'] as String? ?? '';
        final String movieId = args?['movieId'] as String? ?? '';
        return _cupertinoRoute(VideoPlayerScreen(videoUrl: videoUrl,movieId: movieId,));
      case  DetailFilm.routeName:
        final movieId = settings.arguments as String;
        return _cupertinoRoute(DetailFilm(movieId: movieId,));
      case HomeScreen.routeName:
        return _cupertinoRoute(const HomeScreen());
      case CreateAccount.routeName:
        return _cupertinoRoute(const CreateAccount());
      default:
        return _cupertinoRoute(
         const Text('Error')
        );
    }
  }

  static Route _cupertinoRoute(Widget view) => CupertinoPageRoute(
    builder: (_) => view,
  );

  Routes._();

}