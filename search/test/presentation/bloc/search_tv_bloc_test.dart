import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/search_tv.dart';
import 'package:search/presentation/bloc/tv_search/tvseries_search_bloc.dart';
import 'package:tv_series/domain/entities/tv/tv.dart';
import '../../dummy_data/dummy_objects.dart';
import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late TvseriesSearchBloc tvseriesSearchBloc;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    tvseriesSearchBloc = TvseriesSearchBloc(mockSearchTvSeries);
  });

  group('search tvseries feature', () {
    final tTvseriesList = <Tv>[testTv];
    const tTvseriesQuery = "Tokyo Ghoul";

    test('initial state should be empty', () {
      expect(tvseriesSearchBloc.state, TvseriesSearchEmpty());
    });

    blocTest<TvseriesSearchBloc, TvseriesSearchState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchTvSeries.execute(tTvseriesQuery))
            .thenAnswer((_) async => Right(tTvseriesList));
        return tvseriesSearchBloc;
      },
      act: (bloc) => bloc.add(const TvSeriesOnQueryChanged(tTvseriesQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvseriesSearchLoading(),
        TvseriesSearchHasData(tTvseriesList),
      ],
      verify: (bloc) {
        verify(mockSearchTvSeries.execute(tTvseriesQuery));
        return const TvSeriesOnQueryChanged(tTvseriesQuery).props;
      },
    );

    blocTest<TvseriesSearchBloc, TvseriesSearchState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchTvSeries.execute(tTvseriesQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvseriesSearchBloc;
      },
      act: (bloc) => bloc.add(const TvSeriesOnQueryChanged(tTvseriesQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvseriesSearchLoading(),
        const TvseriesSearchError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchTvSeries.execute(tTvseriesQuery));
      },
    );

    blocTest<TvseriesSearchBloc, TvseriesSearchState>(
      'should emit [empty] when get search is empty',
      build: () {
        when(mockSearchTvSeries.execute(tTvseriesQuery))
            .thenAnswer((_) async => const Right([]));
        return tvseriesSearchBloc;
      },
      act: (bloc) => bloc.add(const TvSeriesOnQueryChanged(tTvseriesQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvseriesSearchLoading(),
        const TvseriesSearchHasData([])
      ],
      verify: (bloc) => verify(mockSearchTvSeries.execute(tTvseriesQuery)),
    );
  });
}
