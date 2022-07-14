import 'package:tv_series/domain/repositories/tv_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/tv/tv_detail.dart';

class SaveWatchlistTv {
  final TvRepository repository;
  SaveWatchlistTv(this.repository);
  Future<Either<Failure, String>> execute(DetailTv tv) {
    return repository.saveWatchlist(tv);
  }
}