part of 'watchlist_tvseries_bloc.dart';

@immutable
abstract class WatchlistTvseriesEvent extends Equatable {}

class OnWatchlistTvseries extends WatchlistTvseriesEvent {
  @override
  List<Object?> get props => [];
}

class FetchWatchlistStatus extends WatchlistTvseriesEvent {
  final int id;
  FetchWatchlistStatus(this.id);
  @override
  List<Object?> get props => [id];
}

class AddTvseriesToWatchlist extends WatchlistTvseriesEvent {
  final DetailTv tvseries;
  AddTvseriesToWatchlist(this.tvseries);
  @override
  List<Object?> get props => [tvseries];
}

class RemoveTvseriesFromWatchlist extends WatchlistTvseriesEvent {
  final DetailTv tvseries;
  RemoveTvseriesFromWatchlist(this.tvseries);
  @override
  List<Object?> get props => [tvseries];
}
