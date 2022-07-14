import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv/tv.dart';
import 'package:tv_series/domain/usecases/tv/get_popular_tv.dart';

part 'popular_tvseries_event.dart';
part 'popular_tvseries_state.dart';

class PopularTvseriesBloc
    extends Bloc<PopularTvseriesEvent, PopularTvseriesState> {
  final GetPopularTv _getPopularTvseries;
  PopularTvseriesBloc(this._getPopularTvseries)
      : super(PopularTvseriesEmpty()) {
    on<OnPopularTvseries>((event, emit) async {
      emit(PopularTvseriesLoading());

      final result = await _getPopularTvseries.execute();

      result.fold(
        (failure) => emit(PopularTvseriesError(failure.message)),
        (data) => data.isNotEmpty
            ? emit(PopularTvseriesHasData(data))
            : emit(PopularTvseriesEmpty()),
      );
    });
  }
}
