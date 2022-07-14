import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv/top_rated_tvseries_bloc.dart';

class PageTopRatedTvSeries extends StatefulWidget {
  static const ROUTE_NAME = '/topRatedTvSeries';

  const PageTopRatedTvSeries({Key? key}) : super(key: key);

  @override
  _PageTopRatedTvSeriesState createState() => _PageTopRatedTvSeriesState();
}

class _PageTopRatedTvSeriesState extends State<PageTopRatedTvSeries> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<TopRatedTvseriesBloc>().add(OnTopRatedTvseries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Top Rated TV'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TopRatedTvseriesBloc, TopRatedTvseriesState>(
              builder: (context, state) {
                if (state is TopRatedTvseriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedTvseriesHasData) {
                  final tvserie = state.result;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final tv = tvserie[index];
                      return CardTv(tv);
                    },
                    itemCount: tvserie.length,
                  );
                } else {
                  return Center(
                    key: const Key('error_message'),
                    child: Text((state as TopRatedTvseriesError).message),
                  );
                }
              }),
        )
    );
  }
}
