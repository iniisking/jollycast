import 'package:jollycast/core/model/episodes/get_trending_model.dart';

class TopJollyRes {
  final String message;
  final TopJollyData data;

  TopJollyRes({required this.message, required this.data});
}

class TopJollyData {
  final String message;
  final PaginatedTopJollyPodcasts data;

  TopJollyData({required this.message, required this.data});
}

class PaginatedTopJollyPodcasts {
  final List<TopJollyPodcast> data;
  final int currentPage;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<PageLink> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  PaginatedTopJollyPodcasts({
    required this.data,
    required this.currentPage,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });
}

class TopJollyPodcast {
  final int id;
  final int userId;
  final String title;
  final String author;
  final String categoryName;
  final String categoryType;
  final String pictureUrl;
  final String? coverPictureUrl;
  final String description;
  final dynamic embeddablePlayerSettings;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int subscriberCount;
  final Publisher publisher;

  TopJollyPodcast({
    required this.id,
    required this.userId,
    required this.title,
    required this.author,
    required this.categoryName,
    required this.categoryType,
    required this.pictureUrl,
    required this.coverPictureUrl,
    required this.description,
    required this.embeddablePlayerSettings,
    required this.createdAt,
    required this.updatedAt,
    required this.subscriberCount,
    required this.publisher,
  });
}
