import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/bloc/detail_tv/tvseries_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_recommendations/tvseries_recommendations_bloc.dart';
import 'package:tv_series/presentation/pages/tv_page_detail.dart';
import 'package:watclist/presentation/pages/bloc/watchlist_tv/watchlist_tvseries_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/pages_test_helpers.dart';


void main() {
  late FakeTvseriesDetailBloc fakeTvseriesDetailBloc;
  late FakeWatchlistTvseriesBloc fakeWatchlistTvseriesBloc;
  late FakeTvseriesRecommendationsBloc fakeTvseriesRecommendationsBloc;

  setUpAll(() {
    fakeTvseriesDetailBloc = FakeTvseriesDetailBloc();
    registerFallbackValue(FakeTvseriesDetailEvent());
    registerFallbackValue(FakeTvseriesDetailState());

    fakeWatchlistTvseriesBloc = FakeWatchlistTvseriesBloc();
    registerFallbackValue(FakeWatchlistTvseriesEvent());
    registerFallbackValue(FakeWatchlistTvseriesState());

    fakeTvseriesRecommendationsBloc = FakeTvseriesRecommendationsBloc();
    registerFallbackValue(FakeTvseriesRecommendationsEvent());
    registerFallbackValue(FakeTvseriesRecommendationsState());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvseriesDetailBloc>(
          create: (_) => fakeTvseriesDetailBloc,
        ),
        BlocProvider<WatchlistTvseriesBloc>(
          create: (_) => fakeWatchlistTvseriesBloc,
        ),
        BlocProvider<TvseriesRecommendationsBloc>(
          create: (_) => fakeTvseriesRecommendationsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeTvseriesDetailBloc.close();
    fakeWatchlistTvseriesBloc.close();
    fakeTvseriesRecommendationsBloc.close();
  });

  const testId = 1;

  testWidgets('page should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakeTvseriesDetailBloc.state)
        .thenReturn(TvseriesDetailLoading());
    when(() => fakeWatchlistTvseriesBloc.state)
        .thenReturn(WatchlistTvseriesLoading());
    when(() => fakeTvseriesRecommendationsBloc.state)
        .thenReturn(TvseriesRecommendationsLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const PageDetailTvSeries(
      id: testId,
    )));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets('should widget display which all required',
      (WidgetTester tester) async {
    when(() => fakeTvseriesDetailBloc.state)
        .thenReturn(TvseriesDetailHasData(testTvDetail));
    when(() => fakeWatchlistTvseriesBloc.state)
        .thenReturn(WatchlistTvseriesHasData(testTvList));
    when(() => fakeTvseriesRecommendationsBloc.state)
        .thenReturn(TvseriesRecommendationsHasData(testTvList));
    await tester
        .pumpWidget(_makeTestableWidget(const PageDetailTvSeries(id: testId)));
    await tester.pump();

    expect(find.text('Watchlist TV'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Recommendations TV'), findsOneWidget);
    expect(find.byKey(const Key('tvseries_content_detail')), findsOneWidget);
  });

  testWidgets(
      'should display add icon when Tvseries is not added to watchlist in watchlist button',
      (WidgetTester tester) async {
    when(() => fakeTvseriesDetailBloc.state)
        .thenReturn(TvseriesDetailHasData(testTvDetail));
    when(() => fakeWatchlistTvseriesBloc.state)
        .thenReturn(WatchlistTvseriesIsAdded(false));
    when(() => fakeTvseriesRecommendationsBloc.state)
        .thenReturn(TvseriesRecommendationsHasData(testTvList));
    final addIconFinder = find.byIcon(Icons.add);
    await tester
        .pumpWidget(_makeTestableWidget(const PageDetailTvSeries(id: testId)));
    await tester.pump();
    expect(addIconFinder, findsOneWidget);
  });

  testWidgets(
      'should display check icon when Tvseries is added to watchlist in watchlist button',
      (WidgetTester tester) async {
    when(() => fakeTvseriesDetailBloc.state)
        .thenReturn(TvseriesDetailHasData(testTvDetail));
    when(() => fakeWatchlistTvseriesBloc.state)
        .thenReturn(WatchlistTvseriesIsAdded(true));
    when(() => fakeTvseriesRecommendationsBloc.state)
        .thenReturn(TvseriesRecommendationsHasData(testTvList));
    final checkIconFinder = find.byIcon(Icons.check);
    await tester
        .pumpWidget(_makeTestableWidget(const PageDetailTvSeries(id: testId)));
    await tester.pump();
    expect(checkIconFinder, findsOneWidget);
  });
}
