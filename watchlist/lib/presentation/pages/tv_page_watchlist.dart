import 'package:core/presentation/pages/home_page.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/watchlist_tv/watchlist_tvseries_bloc.dart';

class PageWatchlistTvSeries extends StatefulWidget {
  static const ROUTE_NAME = '/watchlistTvSeries';

  const PageWatchlistTvSeries({Key? key}) : super(key: key);

  @override
  _PageWatchlistTvSeriesState createState() => _PageWatchlistTvSeriesState();
}

class _PageWatchlistTvSeriesState extends State<PageWatchlistTvSeries>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<WatchlistTvseriesBloc>().add(OnWatchlistTvseries()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvseriesBloc>().add(OnWatchlistTvseries());
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvseriesBloc, WatchlistTvseriesState>(
            builder: (context, state) {
          if (state is WatchlistTvseriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTvseriesHasData) {
            final watchlistTvSeries = state.result;
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = watchlistTvSeries[index];
                return CardTv(tv);
              },
              itemCount: watchlistTvSeries.length,
            );
          } else if (state is WatchlistTvseriesEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "You don't have watchlist",
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      PageHome.ROUTE_NAME,
                      (route) => false,
                    ),
                    child: const Text('Add Watchlist'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              key: Key('error_message'),
              child: Text('failed to fetch data'),
            );
          }
        }));
  }
}
