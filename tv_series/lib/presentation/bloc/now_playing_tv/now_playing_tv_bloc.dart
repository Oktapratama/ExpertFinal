import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv/tv.dart';
import 'package:tv_series/domain/usecases/tv/get_now_playing_tv.dart';

part 'now_playing_tv_event.dart';
part 'now_playing_tv_state.dart';

class NowPlayingTvBloc
    extends Bloc<NowPlayingTvEvent, NowPlayingTvState> {
  final GetNowPlayingTv _getNowPlayingTvs;
  NowPlayingTvBloc(this._getNowPlayingTvs)
      : super(NowPlayingTvEmpty()) {
    on<NowPlayingTv>((event, emit) async {
      emit(NowPlayingTvLoading());

      final result = await _getNowPlayingTvs.execute();

      result.fold((failure) {
        emit(NowPlayingTvError(failure.message));
      }, (data) {
        data.isNotEmpty
            ? emit(NowPlayingTvHasData(data))
            : emit(NowPlayingTvEmpty());
      });
    });
  }
}
