import 'package:about/about_page.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:core/presentation/pages/search_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:movies/presentation/bloc/detail_movies/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:movies/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movies/presentation/bloc/recommendations_movies/movie_recommendations_bloc.dart';
import 'package:movies/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:movies/presentation/movie_detail_page.dart';
import 'package:movies/presentation/popular_movies_page.dart';
import 'package:movies/presentation/top_rated_movies_page.dart';
import 'package:search/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:search/presentation/bloc/tv_search/tvseries_search_bloc.dart';
import 'package:search/presentation/pages/search_page_tv.dart';
import 'package:tv_series/presentation/bloc/detail_tv/tvseries_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv/now_playing_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tv/popular_tvseries_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv/top_rated_tvseries_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_recommendations/tvseries_recommendations_bloc.dart';
import 'package:tv_series/presentation/pages/tv_page_detail.dart';
import 'package:tv_series/presentation/pages/tv_page_home.dart';
import 'package:tv_series/presentation/pages/tv_page_popular.dart';
import 'package:tv_series/presentation/pages/tv_page_top_rated.dart';
import 'package:watclist/presentation/pages/bloc/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:watclist/presentation/pages/bloc/watchlist_tv/watchlist_tvseries_bloc.dart';
import 'package:core/utils/ssl_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SSLHelper.init();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<NowPlayingMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieRecommendationsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvseriesSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvseriesRecommendationsBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvseriesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvseriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvseriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvseriesBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
        ),
        home: const PageHome(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case PageHome.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const PageHome());
            case PagePopularMovies.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const PagePopularMovies());
            case PageTopRatedMovies.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const PageTopRatedMovies());
            case PageSearch.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const PageSearch());
            case PageDetailMovie.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => PageDetailMovie(id: id),
                settings: settings,
              );
            case PageHomeTvSeries.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => const PageHomeTvSeries());
            case PagePopularTvSeries.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const PagePopularTvSeries());
            case PageTopRatedTvSeries.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const PageTopRatedTvSeries());
            case PageSearchTvSeries.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const PageSearchTvSeries());
            case PageDetailTvSeries.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => PageDetailTvSeries(id: id),
                settings: settings,
              );

            case PageWatchlist.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const PageWatchlist());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
