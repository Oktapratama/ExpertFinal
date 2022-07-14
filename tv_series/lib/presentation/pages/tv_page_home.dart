import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/entities/tv/tv.dart';
import 'package:tv_series/presentation/bloc/popular_tv/popular_tvseries_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv/top_rated_tvseries_bloc.dart';
import 'package:tv_series/presentation/pages/tv_page_popular.dart';
import 'package:tv_series/presentation/pages/tv_page_top_rated.dart';
import 'package:tv_series/presentation/pages/tv_page_detail.dart';
import '../bloc/now_playing_tv/now_playing_tv_bloc.dart';

class PageHomeTvSeries extends StatefulWidget {
  static const ROUTE_NAME = '/homeTvSeries';

  const PageHomeTvSeries({Key? key}) : super(key: key);
  @override
  _PageHomeTvSeriesState createState() => _PageHomeTvSeriesState();
}

class _PageHomeTvSeriesState extends State<PageHomeTvSeries> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingTvBloc>().add(NowPlayingTv());
      context.read<PopularTvseriesBloc>().add(OnPopularTvseries());
      context.read<TopRatedTvseriesBloc>().add(OnTopRatedTvseries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing Tv',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingTvBloc, NowPlayingTvState>(
                  builder: (context, state) {
                    if (state is NowPlayingTvLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is NowPlayingTvHasData) {
                      final data = state.result;
                      return TvList(data);
                    } else if (state is NowPlayingTvError) {
                      return const Text(
                        'Failed to fetch data',
                        key: Key('error_message'),
                      );
                    } else {
                      return Container();
                    }
                  }),
              _buildSubHeading(
                title: 'Popular TV',
                onTap: () => Navigator.pushNamed(
                    context, PagePopularTvSeries.ROUTE_NAME),
              ),
              BlocBuilder<PopularTvseriesBloc, PopularTvseriesState>(
                  builder: (context, state) {
                    if (state is PopularTvseriesLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is PopularTvseriesHasData) {
                      final data = state.result;
                      return TvList(data);
                    } else if (state is PopularTvseriesError) {
                      return const Text(
                        'Failed to fetch data',
                        key: Key('error_message'),
                      );
                    } else {
                      return Container();
                    }
                  }),
              _buildSubHeading(
                title: 'Top Rated TV',
                onTap: () => Navigator.pushNamed(
                    context, PageTopRatedTvSeries.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTvseriesBloc, TopRatedTvseriesState>(
                  builder: (context, state) {
                    if (state is TopRatedTvseriesLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TopRatedTvseriesHasData) {
                      final data = state.result;
                      return TvList(data);
                    } else if (state is TopRatedTvseriesError) {
                      return const Text(
                        'Failed to fetch data',
                        key: Key('error_message'),
                      );
                    } else {
                      return Container();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvSeries;

  const TvList(this.tvSeries, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final result = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  PageDetailTvSeries.ROUTE_NAME,
                  arguments: result.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${result.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
