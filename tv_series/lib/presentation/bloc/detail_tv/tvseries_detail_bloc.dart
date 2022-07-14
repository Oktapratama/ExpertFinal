import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv/tv_detail.dart';
import 'package:tv_series/domain/usecases/tv/get_tv_detail.dart';

part 'tvseries_detail_event.dart';
part 'tvseries_detail_state.dart';

class TvseriesDetailBloc
    extends Bloc<TvseriesDetailEvent, TvseriesDetailState> {
  final GetTvDetail _getTvseriesDetail;
  TvseriesDetailBloc(this._getTvseriesDetail) : super(TvseriesDetailEmpty()) {
    on<OnTvseriesDetail>((event, emit) async {
      final id = event.id;

      emit(TvseriesDetailLoading());

      final result = await _getTvseriesDetail.execute(id);

      result.fold((failure) => emit(TvseriesDetailError(failure.message)),
          (data) => emit(TvseriesDetailHasData(data)));
    });
  }
}
