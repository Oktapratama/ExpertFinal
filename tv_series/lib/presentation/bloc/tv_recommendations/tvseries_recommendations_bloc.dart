import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv/tv.dart';
import '../../../domain/usecases/tv/get_tv_recommendations.dart';

part 'tvseries_recommendations_event.dart';
part 'tvseries_recommendations_state.dart';

class TvseriesRecommendationsBloc
    extends Bloc<TvseriesRecommendationsEvent, TvseriesRecommendationsState> {
  final GetTvRecommendations _getTvseriesRecommendations;
  TvseriesRecommendationsBloc(this._getTvseriesRecommendations)
      : super(TvseriesRecommendationsEmpty()) {
    on<OnTvseriesRecommendationsCalled>((event, emit) async {
      final id = event.id;

      emit(TvseriesRecommendationsLoading());

      final result = await _getTvseriesRecommendations.execute(id);

      result.fold(
        (failure) => emit(TvseriesRecommendationsError(failure.message)),
        (data) => data.isNotEmpty
            ? emit(TvseriesRecommendationsHasData(data))
            : emit(TvseriesRecommendationsEmpty()),
      );
    });
  }
}
