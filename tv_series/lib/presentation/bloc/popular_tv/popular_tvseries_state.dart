part of 'popular_tvseries_bloc.dart';

@immutable
abstract class PopularTvseriesState extends Equatable {}

class PopularTvseriesEmpty extends PopularTvseriesState {
  @override
  List<Object> get props => [];
}

class PopularTvseriesLoading extends PopularTvseriesState {
  @override
  List<Object> get props => [];
}

class PopularTvseriesError extends PopularTvseriesState {
  final String message;
  PopularTvseriesError(this.message);
  @override
  List<Object> get props => [message];
}

class PopularTvseriesHasData extends PopularTvseriesState {
  final List<Tv> result;
  PopularTvseriesHasData(this.result);
  @override
  List<Object> get props => [result];
}
