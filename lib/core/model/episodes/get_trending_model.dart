class GetTrendingRes {
  final String message;
  final TrendingData data;

  GetTrendingRes({required this.message, required this.data});
}

class TrendingData {
  final String message;
  final PaginatedEpisodes data;

  TrendingData({required this.message, required this.data});
}

class PaginatedEpisodes {
  final List<Episode> data;
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

  PaginatedEpisodes({
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

class PageLink {
  final String? url;
  final String label;
  final bool active;

  PageLink({required this.url, required this.label, required this.active});
}

class Episode {
  final int id;
  final int podcastId;
  final String contentUrl;
  final String title;
  final int? season;
  final int? number;
  final String pictureUrl;
  final String description;
  final bool explicit;
  final int duration;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int playCount;
  final int likeCount;
  final double? averageRating;
  final Podcast podcast;
  final DateTime publishedAt;

  Episode({
    required this.id,
    required this.podcastId,
    required this.contentUrl,
    required this.title,
    required this.season,
    required this.number,
    required this.pictureUrl,
    required this.description,
    required this.explicit,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
    required this.playCount,
    required this.likeCount,
    required this.averageRating,
    required this.podcast,
    required this.publishedAt,
  });
}

class Podcast {
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
  final Publisher publisher;

  Podcast({
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
    required this.publisher,
  });
}

class Publisher {
  final int id;
  final String firstName;
  final String lastName;
  final String companyName;
  final String email;
  final String? profileImageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Publisher({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.companyName,
    required this.email,
    required this.profileImageUrl,
    required this.createdAt,
    required this.updatedAt,
  });
}
