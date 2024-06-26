import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:movie_streaming_app/features/auth/presentation/screens/login.dart';
import 'config/routes/routes.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/reponsitory/auth_reponsitory.dart';
import 'features/detailMovie/repository/genreRepository.dart';
import 'features/detailMovie/repository/reviewRepository.dart';
import 'features/detailMovie/repository/watched_list_repository.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/home/reponsitory/genresReponsitory.dart';
import 'features/home/reponsitory/moviesReponsitory.dart';
import 'features/personal/bloc/watched_list_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ancsagqowyumcwusjxhz.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFuY3NhZ3Fvd3l1bWN3dXNqeGh6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTgzNzAxMjksImV4cCI6MjAzMzk0NjEyOX0.kBNbNwu25zRvixP-JpqGKPgdHTnpmwdOcUFYtiEshvY',
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => GenresReponsitory()),
        RepositoryProvider(create:(context) => MoviesReponsitory()),
        RepositoryProvider(create:(context) => ReviewRepository()),
        RepositoryProvider(create:(context) => GenreRepository()),
        RepositoryProvider(create:(context) => WatchedListRepository()),
        BlocProvider(create: (context) => AuthBloc(AuthReponsitory())),

      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthStateHandler(),
        onGenerateRoute: Routes.onGenerateRoute,
      ),
    );
  }
}

class AuthStateHandler extends StatelessWidget {
  const AuthStateHandler({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final session = snapshot.data?.session;
        final user = session?.user;
        if (user != null) {
            return const HomeScreen();
        }
        return const Login();
      },
    );
  }
}


