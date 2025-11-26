import 'package:jollycast/core/model/episodes/get_trending_model.dart';

class LatestEpisodesRes {
  final String message;
  final LatestEpisodesData data;

  LatestEpisodesRes({required this.message, required this.data});
}

class LatestEpisodesData {
  final String message;
  final PaginatedEpisodes data;

  LatestEpisodesData({required this.message, required this.data});
}
