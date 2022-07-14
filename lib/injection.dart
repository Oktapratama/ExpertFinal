import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/db/database_helper_tv.dart';
import 'package:core/data/datasources/movie_local_data_source.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_local_data_resource.dart';
import 'package:core/data/datasources/tv_remote_data_resource.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:http/http.dart' as http;
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/domain/repositories/movie_repository.dart';
import 'package:movies/domain/usecase/get_movie_detail.dart';
import 'package:movies/domain/usecase/get_movie_recommendations.dart';
import 'package:movies/domain/usecase/get_now_playing_movies.dart';
import 'package:movies/domain/usecase/get_popular_movies.dart';
import 'package:movies/domain/usecase/get_top_rated_movies.dart';
import 'package:movies/presentation/bloc/detail_movies/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:movies/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movies/presentation/bloc/recommendations_movies/movie_recommendations_bloc.dart';
import 'package:movies/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:search/domain/search_movies.dart';
import 'package:search/domain/search_tv.dart';
import 'package:search/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:search/presentation/bloc/tv_search/tvseries_search_bloc.dart';
import 'package:tv_series/domain/repositories/tv_repository.dart';
import 'package:tv_series/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:tv_series/domain/usecases/tv/get_popular_tv.dart';
import 'package:tv_series/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:tv_series/domain/usecases/tv/get_tv_detail.dart';
import 'package:tv_series/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:tv_series/presentation/bloc/detail_tv/tvseries_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv/now_playing_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tv/popular_tvseries_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv/top_rated_tvseries_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_recommendations/tvseries_recommendations_bloc.dart';
import 'package:watclist/domain/movies/get_watchlist_movies.dart';
import 'package:watclist/domain/movies/get_watchlist_status.dart';
import 'package:watclist/domain/movies/remove_watchlist.dart';
import 'package:watclist/domain/movies/save_watchlist.dart';
import 'package:watclist/domain/tvseries/get_watchlist_status_tv.dart';
import 'package:watclist/domain/tvseries/get_watchlist_tv.dart';
import 'package:watclist/domain/tvseries/remove_watchlist_tv.dart';
import 'package:watclist/domain/tvseries/save_watchlist_tv.dart';
import 'package:watclist/presentation/pages/bloc/watchlist_movies/watchlist_movies_bloc.dart';
import 'package:watclist/presentation/pages/bloc/watchlist_tv/watchlist_tvseries_bloc.dart';
import 'package:core/utils/ssl_helper.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // BLoC - Movies
  locator.registerFactory<NowPlayingMovieBloc>(
        () => NowPlayingMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => MovieRecommendationsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => MovieSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => MovieDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TopRatedMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => PopularMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => WatchlistMoviesBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  // BLoC - TvSeries
  locator.registerFactory(
        () => NowPlayingTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TvseriesRecommendationsBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TvseriesSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TvseriesDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TopRatedTvseriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => PopularTvseriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => WatchlistTvseriesBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );


  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  // Repository
  locator.registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
        () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSourceTv: locator(),
    ),
  );

  // Datasource
  locator.registerLazySingleton<MovieRemoteDataSource>(
          () => MovieRemoteDataSourceImpl(ioClient: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
          () => TvRemoteDataSourceImpl(ioClient: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
          () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
          () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // Helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<DatabaseHelperTv>(
          () => DatabaseHelperTv());

  // External
  locator.registerLazySingleton(() => http.Client);
  locator.registerLazySingleton(() => SSLHelper.client);
}
