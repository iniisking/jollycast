import 'package:jollycast/core/model/episodes/get_trending_model.dart';

class HandpickedRes {
  final String message;
  final HandpickedData data;

  HandpickedRes({required this.message, required this.data});
}

class HandpickedData {
  final String message;
  final HandpickedEpisodesData data;

  HandpickedData({required this.message, required this.data});
}

class HandpickedEpisodesData {
  final List<Episode> data;

  HandpickedEpisodesData({required this.data});
}
