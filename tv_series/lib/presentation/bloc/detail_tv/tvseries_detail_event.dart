part of 'tvseries_detail_bloc.dart';

@immutable
abstract class TvseriesDetailEvent extends Equatable {}

class OnTvseriesDetail extends TvseriesDetailEvent {
  final int id;

  OnTvseriesDetail(this.id);
  @override
  List<Object?> get props => [id];
}
