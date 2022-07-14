import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tv/popular_tvseries_bloc.dart';

class PagePopularTvSeries extends StatefulWidget {
  static const ROUTE_NAME = '/popularTvSeries';

  const PagePopularTvSeries({Key? key}) : super(key: key);

  @override
  _PagePopularTvSeriesState createState() => _PagePopularTvSeriesState();
}

class _PagePopularTvSeriesState extends State<PagePopularTvSeries> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<PopularTvseriesBloc>().add(OnPopularTvseries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Popular TV'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PopularTvseriesBloc, PopularTvseriesState>(
              builder: (context, state) {
                if (state is PopularTvseriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTvseriesHasData) {
                  final tvseries = state.result;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final tv = tvseries[index];
                      return CardTv(tv);
                    },
                    itemCount: tvseries.length,
                  );
                } else {
                  return Center(
                    key: const Key('error_message'),
                    child: Text((state as PopularTvseriesError).message),
                  );
                }
              }),
        )
    );
  }
}
