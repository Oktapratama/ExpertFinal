import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv/tv.dart';
import 'package:tv_series/domain/usecases/tv/get_top_rated_tv.dart';

part 'top_rated_tvseries_event.dart';
part 'top_rated_tvseries_state.dart';

class TopRatedTvseriesBloc
    extends Bloc<TopRatedTvseriesEvent, TopRatedTvseriesState> {
  final GetTopRatedTv _getTopRatedTvseries;
  TopRatedTvseriesBloc(this._getTopRatedTvseries)
      : super(TopRatedTvseriesEmpty()) {
    on<OnTopRatedTvseries>((event, emit) async {
      emit(TopRatedTvseriesLoading());
      final result = await _getTopRatedTvseries.execute();

      result.fold(
        (failure) => emit(TopRatedTvseriesError(failure.message)),
        (data) => data.isNotEmpty
            ? emit(TopRatedTvseriesHasData(data))
            : emit(TopRatedTvseriesEmpty()),
      );
    });
  }
}
