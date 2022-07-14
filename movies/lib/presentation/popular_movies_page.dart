import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:movies/presentation/bloc/popular_movies/popular_movies_bloc.dart';

class PagePopularMovies extends StatefulWidget {
  static const ROUTE_NAME = '/popularMovie';

  const PagePopularMovies({Key? key}) : super(key: key);

  @override
  _PagePopularMoviesState createState() => _PagePopularMoviesState();
}

class _PagePopularMoviesState extends State<PagePopularMovies> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<PopularMoviesBloc>().add(OnPopularMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Popular Movies'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
              builder: (context, state) {
                if (state is PopularMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularMoviesHasData) {
                  final movies = state.result;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return MovieCard(movie);
                    },
                    itemCount: movies.length,
                  );
                } else {
                  return Center(
                    key: const Key('error_message'),
                    child: Text((state as PopularMoviesError).message),
                  );
                }
              }),
        )
    );
  }
}
