import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:search/presentation/bloc/tv_search/tvseries_search_bloc.dart';

class PageSearchTvSeries extends StatelessWidget {
  static const ROUTE_NAME = '/searchTvSeries';

  const PageSearchTvSeries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: (query) {
              context
                  .read<TvseriesSearchBloc>()
                  .add(TvSeriesOnQueryChanged(query));
            },
            decoration: const InputDecoration(
              hintText: 'Search series title',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.search,
          ),
          const SizedBox(height: 16),
          Text(
            'Search Result',
            style: kHeading6,
          ),
          _buildSearchTv()
        ],
      ),
    );
  }
}

Widget _buildSearchTv() {
  return BlocBuilder<TvseriesSearchBloc, TvseriesSearchState>(
    builder: (context, state) {
      if (state is TvseriesSearchLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is TvseriesSearchHasData) {
        final result = state.result;
        return Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final tvseries = result[index];
              return CardTv(tvseries);
            },
            itemCount: result.length,
          ),
        );
      } else if (state is TvseriesSearchError) {
        return Expanded(
          child: Center(
            child: Text(state.message),
          ),
        );
      } else {
        return Expanded(
          child: Container(),
        );
      }
    },
  );
}
