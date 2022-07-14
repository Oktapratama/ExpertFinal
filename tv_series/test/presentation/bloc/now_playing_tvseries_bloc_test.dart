import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv/now_playing_tv_bloc.dart';
import '../../dummy_data/dummy_objects.dart';
import 'now_playing_tvseries_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv])
void main() {
  late MockGetOnTheAirTvSeries mockGetOnTheAirTvseries;
  late NowPlayingTvBloc nowPlayingTvBloc;

  setUp(() {
    mockGetOnTheAirTvseries = MockGetOnTheAirTvSeries();
    nowPlayingTvBloc = NowPlayingTvBloc(mockGetOnTheAirTvseries);
  });

  test('the OnTheAirTvseriesBloc initial state should be empty ', () {
    expect(nowPlayingTvBloc.state, NowPlayingTvEmpty());
  });

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
      'should emits NowPlayingTvLoading() state and then OnTheAirTvseriesHasData state when data is successfully fetched..',
      build: () {
        when(mockGetOnTheAirTvseries.execute())
            .thenAnswer((_) async => Right(testTvList));
        return nowPlayingTvBloc;
      },
      act: (bloc) => bloc.add(NowPlayingTv()),
      expect: () => <NowPlayingTvState>[
            NowPlayingTvLoading(),
            NowPlayingTvHasData(testTvList),
          ],
      verify: (bloc) {
        verify(mockGetOnTheAirTvseries.execute());
        return NowPlayingTv().props;
      });

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'should emits NowPlayingTvLoading() state and then OnTheAirTvseriesError state when data is failed fetched..',
    build: () {
      when(mockGetOnTheAirTvseries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(NowPlayingTv()),
    expect: () => <NowPlayingTvState>[
      NowPlayingTvLoading(),
      NowPlayingTvError('Server Failure'),
    ],
    verify: (bloc) => NowPlayingTvLoading(),
  );

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'should emits NowPlayingTvLoading state and then NowPlayingTvEmpty state when data is retrieved empty..',
    build: () {
      when(mockGetOnTheAirTvseries.execute())
          .thenAnswer((_) async => const Right([]));
      return nowPlayingTvBloc;
    },
    act: (bloc) => bloc.add(NowPlayingTv()),
    expect: () => <NowPlayingTvState>[
      NowPlayingTvLoading(),
      NowPlayingTvEmpty(),
    ],
  );
}
