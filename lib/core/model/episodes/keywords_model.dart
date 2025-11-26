import 'package:jollycast/core/model/episodes/get_trending_model.dart';

class KeywordsRes {
  final String message;
  final KeywordsData data;

  KeywordsRes({required this.message, required this.data});
}

class KeywordsData {
  final String message;
  final PaginatedKeywords data;

  KeywordsData({required this.message, required this.data});
}

class PaginatedKeywords {
  final List<Keyword> data;
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

  PaginatedKeywords({
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

class Keyword {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  Keyword({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
}
