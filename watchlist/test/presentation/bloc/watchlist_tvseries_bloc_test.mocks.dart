
import 'dart:async' as _i5;

import 'package:tv_series/domain/entities/tv/tv.dart' as _i8;
import 'package:tv_series/domain/entities/tv/tv_detail.dart' as _i10;
import 'package:tv_series/domain/repositories/tv_repository.dart' as _i2;
import 'package:watclist/domain/tvseries/get_watchlist_tv.dart' as _i6;
import 'package:watclist/domain/tvseries/get_watchlist_status_tv.dart'
as _i4;
import 'package:watclist/domain/tvseries/remove_watchlist_tv.dart'
as _i9;
import 'package:watclist/domain/tvseries/save_watchlist_tv.dart' as _i11;
import 'package:core/utils/failure.dart' as _i7;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

class _FakeTvSeriesRepository_0 extends _i1.Fake implements _i2.TvRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetWatchListStatusMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatusTvSeries extends _i1.Mock
    implements _i4.GetWatchListStatusTv {
  MockGetWatchListStatusTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_0()) as _i2.TvRepository);
  @override
  _i5.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
}

/// A class which mocks [GetWatchlistTvSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistTvSeries extends _i1.Mock
    implements _i6.GetWatchlistTv {
  MockGetWatchlistTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.Either<_i7.Failure, List<_i8.Tv>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i7.Failure, List<_i8.Tv>>>.value(
              _FakeEither_1<_i7.Failure, List<_i8.Tv>>())) as _i5
          .Future<_i3.Either<_i7.Failure, List<_i8.Tv>>>);
}

/// A class which mocks [RemoveWatchlistMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistTvSeries extends _i1.Mock
    implements _i9.RemoveWatchlistTv {
  MockRemoveWatchlistTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_0()) as _i2.TvRepository);
  @override
  _i5.Future<_i3.Either<_i7.Failure, String>> execute(
      _i10.DetailTv? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
          returnValue: Future<_i3.Either<_i7.Failure, String>>.value(
              _FakeEither_1<_i7.Failure, String>()))
      as _i5.Future<_i3.Either<_i7.Failure, String>>);
}

/// A class which mocks [SaveWatchlistMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistTvSeries extends _i1.Mock
    implements _i11.SaveWatchlistTv {
  MockSaveWatchlistTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_0()) as _i2.TvRepository);
  @override
  _i5.Future<_i3.Either<_i7.Failure, String>> execute(
      _i10.DetailTv? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
          returnValue: Future<_i3.Either<_i7.Failure, String>>.value(
              _FakeEither_1<_i7.Failure, String>()))
      as _i5.Future<_i3.Either<_i7.Failure, String>>);
}
