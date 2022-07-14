import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv/now_playing_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tv/popular_tvseries_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv/top_rated_tvseries_bloc.dart';
import 'package:tv_series/presentation/bloc/detail_tv/tvseries_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_recommendations/tvseries_recommendations_bloc.dart';
import 'package:watclist/presentation/pages/bloc/watchlist_tv/watchlist_tvseries_bloc.dart';


// fake now playing Tvseies bloc
class FakeOnTheAirTvseriesEvent extends Fake implements NowPlayingTvEvent {}

class FakeOnTheAirTvseriesState extends Fake implements NowPlayingTvState {}

class FakeOnTheAirTvseriesBloc
    extends MockBloc<NowPlayingTvEvent, NowPlayingTvState>
    implements NowPlayingTvBloc {}

// fake popular Tvseries bloc
class FakePopularTvseriesEvent extends Fake implements PopularTvseriesEvent {}

class FakePopularTvseriesState extends Fake implements PopularTvseriesState {}

class FakePopularTvseriesBloc
    extends MockBloc<PopularTvseriesEvent, PopularTvseriesState>
    implements PopularTvseriesBloc {}

// fake top rated Tvseries bloc
class FakeTopRatedTvseriesEvent extends Fake implements TopRatedTvseriesEvent {}

class FakeTopRatedTvseriesState extends Fake implements TopRatedTvseriesState {}

class FakeTopRatedTvseriesBloc
    extends MockBloc<TopRatedTvseriesEvent, TopRatedTvseriesState>
    implements TopRatedTvseriesBloc {}

// fake detail Tvseries bloc
class FakeTvseriesDetailEvent extends Fake implements TvseriesDetailEvent {}

class FakeTvseriesDetailState extends Fake implements TvseriesDetailState {}

class FakeTvseriesDetailBloc
    extends MockBloc<TvseriesDetailEvent, TvseriesDetailState>
    implements TvseriesDetailBloc {}

// fake Tvseries recommendations bloc
class FakeTvseriesRecommendationsEvent extends Fake
    implements TvseriesRecommendationsEvent {}

class FakeTvseriesRecommendationsState extends Fake
    implements TvseriesRecommendationsState {}

class FakeTvseriesRecommendationsBloc
    extends MockBloc<TvseriesRecommendationsEvent, TvseriesRecommendationsState>
    implements TvseriesRecommendationsBloc {}

// fake watchlist Tvseries bloc
class FakeWatchlistTvseriesEvent extends Fake
    implements WatchlistTvseriesEvent {}

class FakeWatchlistTvseriesState extends Fake
    implements WatchlistTvseriesState {}

class FakeWatchlistTvseriesBloc
    extends MockBloc<WatchlistTvseriesEvent, WatchlistTvseriesState>
    implements WatchlistTvseriesBloc {}
