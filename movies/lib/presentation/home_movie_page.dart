import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:movies/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movies/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:movies/presentation/movie_detail_page.dart';
import 'package:movies/presentation/popular_movies_page.dart';
import 'package:movies/presentation/top_rated_movies_page.dart';

class PageHomeMovie extends StatefulWidget {
  const PageHomeMovie({Key? key}) : super(key: key);

  @override
  _PageHomeMovieState createState() => _PageHomeMovieState();
  static const routeName = '/homeMovie';
}

class _PageHomeMovieState extends State<PageHomeMovie> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<NowPlayingMovieBloc>(context, listen: false)
          .add(OnNowPlayingMovie());
      BlocProvider.of<TopRatedMoviesBloc>(context, listen: false)
          .add(OnTopRatedMovies());
      BlocProvider.of<PopularMoviesBloc>(context, listen: false)
          .add(OnPopularMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing Movies',
              style: kHeading6,
            ),
            BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
                builder: (context, state) {
                  if (state is NowPlayingMovieLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingMovieHasData) {
                    final data = state.result;
                    return MovieList(data);
                  } else if (state is NowPlayingMovieError) {
                    return const Text(
                      'Failed to fetch data',
                      key: Key('error_message'),
                    );
                  } else {
                    return Container();
                  }
                }),
            _buildSubHeading(
              title: 'Popular Movie',
              onTap: () =>
                  Navigator.pushNamed(context, PagePopularMovies.ROUTE_NAME),
            ),
            BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                builder: (context, state) {
                  if (state is NowPlayingMovieLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularMoviesHasData) {
                    return MovieList(state.result);
                  } else if (state is PopularMoviesError) {
                    return Text(state.message);
                  } else {
                    return const Center();
                  }
                }),
            _buildSubHeading(
              title: 'Top Rated Movie',
              onTap: () =>
                  Navigator.pushNamed(context, PageTopRatedMovies.ROUTE_NAME),
            ),
            BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
                builder: (context, state) {
                  if (state is TopRatedMoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedMoviesHasData) {
                    return MovieList(state.result);
                  } else if (state is TopRatedMoviesError) {
                    return Text(state.message);
                  } else {
                    return const Center();
                  }
                }),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  PageDetailMovie.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
