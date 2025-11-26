import 'dart:convert';
import 'package:jollycast/config/api_endpoints.dart';
import 'package:jollycast/core/model/episodes/get_trending_model.dart';
import 'package:jollycast/core/model/episodes/editors_pick_model.dart';
import 'package:jollycast/core/model/episodes/top_jolly_model.dart';
import 'package:jollycast/core/model/episodes/latest_episodes_model.dart';
import 'package:jollycast/core/model/episodes/handpicked_model.dart';
import 'package:jollycast/core/model/episodes/keywords_model.dart';
import 'package:jollycast/core/services/api_service.dart';
import 'package:jollycast/utils/error_parser.dart';
import 'package:jollycast/utils/logger.dart';

class EpisodesService {
  // Helper method to build headers with authorization
  static Map<String, String> _buildHeaders({String? token}) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // Get trending episodes
  static Future<GetTrendingRes> getTrendingEpisodes({
    int page = 1,
    int perPage = 1,
    String? token,
  }) async {
    try {
      final response = await ApiService.get(
        ApiEndpoints.trendingEpisodes(page: page, perPage: perPage),
        headers: _buildHeaders(token: token),
      );

      if (ApiService.isSuccess(response.statusCode)) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        AppLogger.info('Trending episodes fetched successfully');
        return _parseTrendingResponse(jsonData);
      } else {
        final errorMessage = ErrorParser.parseErrorResponse(response.body);
        AppLogger.error(
          'Failed to fetch trending episodes',
          'Status: ${response.statusCode}, Body: ${response.body}',
        );
        throw Exception(errorMessage);
      }
    } catch (e) {
      rethrow;
    }
  }

  // Parse trending episodes response
  static GetTrendingRes _parseTrendingResponse(Map<String, dynamic> json) {
    return GetTrendingRes(
      message: json['message'] as String,
      data: TrendingData(
        message: json['data']['message'] as String,
        data: _parsePaginatedEpisodes(
          json['data']['data'] as Map<String, dynamic>,
        ),
      ),
    );
  }

  // Parse paginated episodes
  static PaginatedEpisodes _parsePaginatedEpisodes(Map<String, dynamic> json) {
    return PaginatedEpisodes(
      data: (json['data'] as List)
          .map((e) => _parseEpisode(e as Map<String, dynamic>))
          .toList(),
      currentPage: json['current_page'] as int,
      firstPageUrl: json['first_page_url'] as String,
      from: json['from'] as int,
      lastPage: json['last_page'] as int,
      lastPageUrl: json['last_page_url'] as String,
      links: (json['links'] as List)
          .map((e) => _parsePageLink(e as Map<String, dynamic>))
          .toList(),
      nextPageUrl: json['next_page_url'] as String?,
      path: json['path'] as String,
      perPage: json['per_page'] as int,
      prevPageUrl: json['prev_page_url'] as String?,
      to: json['to'] as int,
      total: json['total'] as int,
    );
  }

  // Parse episode
  static Episode _parseEpisode(Map<String, dynamic> json) {
    return Episode(
      id: json['id'] as int,
      podcastId: json['podcast_id'] as int,
      contentUrl: json['content_url'] as String,
      title: json['title'] as String,
      season: json['season'] as int?,
      number: json['number'] as int?,
      pictureUrl: json['picture_url'] as String,
      description: json['description'] as String,
      explicit: json['explicit'] as bool,
      duration: json['duration'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      playCount: json['play_count'] as int,
      likeCount: json['like_count'] as int,
      averageRating: json['average_rating'] != null
          ? (json['average_rating'] as num).toDouble()
          : null,
      podcast: _parsePodcast(json['podcast'] as Map<String, dynamic>),
      publishedAt: DateTime.parse(json['published_at'] as String),
    );
  }

  // Get single episode by id
  static Future<Episode> getEpisodeById({
    required int id,
    String? token,
  }) async {
    try {
      final response = await ApiService.get(
        ApiEndpoints.episode(id),
        headers: _buildHeaders(token: token),
      );

      if (ApiService.isSuccess(response.statusCode)) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        AppLogger.info('Episode $id fetched successfully');
        final data = jsonData['data']['data'] as Map<String, dynamic>;
        return _parseEpisode(data);
      } else {
        final errorMessage = ErrorParser.parseErrorResponse(response.body);
        AppLogger.error(
          'Failed to fetch episode $id',
          'Status: ${response.statusCode}, Body: ${response.body}',
        );
        throw Exception(errorMessage);
      }
    } catch (e) {
      rethrow;
    }
  }

  // Parse podcast
  static Podcast _parsePodcast(Map<String, dynamic> json) {
    return Podcast(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      categoryName: (json['category_name'] as String?) ?? '',
      categoryType: (json['category_type'] as String?) ?? '',
      pictureUrl: json['picture_url'] as String,
      coverPictureUrl: json['cover_picture_url'] as String?,
      description: (json['description'] as String?) ?? '',
      embeddablePlayerSettings: json['embeddable_player_settings'],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      publisher: _parsePublisher(json['publisher'] as Map<String, dynamic>),
    );
  }

  // Parse publisher
  static Publisher _parsePublisher(Map<String, dynamic> json) {
    return Publisher(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      companyName: json['company_name'] as String,
      email: json['email'] as String,
      profileImageUrl: json['profile_image_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  // Parse page link
  static PageLink _parsePageLink(Map<String, dynamic> json) {
    return PageLink(
      url: json['url'] as String?,
      label: json['label'] as String,
      active: json['active'] as bool,
    );
  }

  // Get editor's pick
  static Future<EditorsPickRes> getEditorsPick({String? token}) async {
    try {
      final response = await ApiService.get(
        ApiEndpoints.editorsPick,
        headers: _buildHeaders(token: token),
      );

      if (ApiService.isSuccess(response.statusCode)) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        AppLogger.info('Editor\'s pick fetched successfully');
        return _parseEditorsPickResponse(jsonData);
      } else {
        final errorMessage = ErrorParser.parseErrorResponse(response.body);
        AppLogger.error(
          'Failed to fetch editor\'s pick',
          'Status: ${response.statusCode}, Body: ${response.body}',
        );
        throw Exception(errorMessage);
      }
    } catch (e) {
      rethrow;
    }
  }

  // Parse editor's pick response
  static EditorsPickRes _parseEditorsPickResponse(Map<String, dynamic> json) {
    return EditorsPickRes(
      message: json['message'] as String,
      data: EditorsPickData(
        message: json['data']['message'] as String,
        episode: _parseEditorsPickEpisode(
          json['data']['data'] as Map<String, dynamic>,
        ),
      ),
    );
  }

  // Parse editor's pick episode (slightly different structure - no play_count, like_count, publisher)
  static Episode _parseEditorsPickEpisode(Map<String, dynamic> json) {
    return Episode(
      id: json['id'] as int,
      podcastId: json['podcast_id'] as int,
      contentUrl: json['content_url'] as String,
      title: json['title'] as String,
      season: json['season'] as int?,
      number: json['number'] as int?,
      pictureUrl: json['picture_url'] as String,
      description: json['description'] as String,
      explicit: json['explicit'] as bool,
      duration: json['duration'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      playCount: 0, // Not in editor's pick response
      likeCount: 0, // Not in editor's pick response
      averageRating: json['average_rating'] != null
          ? (json['average_rating'] as num).toDouble()
          : null,
      podcast: _parseEditorsPickPodcast(
        json['podcast'] as Map<String, dynamic>,
      ),
      publishedAt: DateTime.parse(json['published_at'] as String),
    );
  }

  // Parse editor's pick podcast (no publisher field)
  static Podcast _parseEditorsPickPodcast(Map<String, dynamic> json) {
    return Podcast(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      categoryName: (json['category_name'] as String?) ?? '',
      categoryType: (json['category_type'] as String?) ?? '',
      pictureUrl: json['picture_url'] as String,
      coverPictureUrl: json['cover_picture_url'] as String?,
      description: (json['description'] as String?) ?? '',
      embeddablePlayerSettings: json['embeddable_player_settings'],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      publisher: Publisher(
        id: 0,
        firstName: '',
        lastName: '',
        companyName: '',
        email: '',
        profileImageUrl: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ), // Publisher not in editor's pick response
    );
  }

  // Get top jolly podcasts
  static Future<TopJollyRes> getTopJolly({
    int page = 1,
    int perPage = 1,
    String? token,
  }) async {
    try {
      final response = await ApiService.get(
        ApiEndpoints.topJolly(page: page, perPage: perPage),
        headers: _buildHeaders(token: token),
      );

      if (ApiService.isSuccess(response.statusCode)) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        AppLogger.info('Top jolly fetched successfully');
        return _parseTopJollyResponse(jsonData);
      } else {
        final errorMessage = ErrorParser.parseErrorResponse(response.body);
        AppLogger.error(
          'Failed to fetch top jolly',
          'Status: ${response.statusCode}, Body: ${response.body}',
        );
        throw Exception(errorMessage);
      }
    } catch (e) {
      rethrow;
    }
  }

  // Parse top jolly response
  static TopJollyRes _parseTopJollyResponse(Map<String, dynamic> json) {
    return TopJollyRes(
      message: json['message'] as String,
      data: TopJollyData(
        message: json['data']['message'] as String,
        data: _parsePaginatedTopJollyPodcasts(
          json['data']['data'] as Map<String, dynamic>,
        ),
      ),
    );
  }

  // Parse paginated top jolly podcasts
  static PaginatedTopJollyPodcasts _parsePaginatedTopJollyPodcasts(
    Map<String, dynamic> json,
  ) {
    return PaginatedTopJollyPodcasts(
      data: (json['data'] as List<dynamic>)
          .map((e) => _parseTopJollyPodcast(e as Map<String, dynamic>))
          .toList(),
      currentPage: json['current_page'] as int,
      firstPageUrl: json['first_page_url'] as String,
      from: json['from'] as int,
      lastPage: json['last_page'] as int,
      lastPageUrl: json['last_page_url'] as String,
      links: (json['links'] as List<dynamic>)
          .map((e) => _parsePageLink(e as Map<String, dynamic>))
          .toList(),
      nextPageUrl: json['next_page_url'] as String?,
      path: json['path'] as String,
      perPage: json['per_page'] as int,
      prevPageUrl: json['prev_page_url'] as String?,
      to: json['to'] as int,
      total: json['total'] as int,
    );
  }

  // Parse top jolly podcast
  static TopJollyPodcast _parseTopJollyPodcast(Map<String, dynamic> json) {
    return TopJollyPodcast(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      categoryName: json['category_name'] as String,
      categoryType: json['category_type'] as String,
      pictureUrl: json['picture_url'] as String,
      coverPictureUrl: json['cover_picture_url'] as String?,
      description: json['description'] as String,
      embeddablePlayerSettings: json['embeddable_player_settings'],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      subscriberCount: json['subscriber_count'] as int,
      publisher: _parsePublisher(json['publisher'] as Map<String, dynamic>),
    );
  }

  // Get latest episodes
  static Future<LatestEpisodesRes> getLatestEpisodes({
    int page = 1,
    int perPage = 20,
    String? token,
  }) async {
    try {
      final response = await ApiService.get(
        ApiEndpoints.latestEpisodes(page: page, perPage: perPage),
        headers: _buildHeaders(token: token),
      );

      if (ApiService.isSuccess(response.statusCode)) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        AppLogger.info('Latest episodes fetched successfully');
        return _parseLatestEpisodesResponse(jsonData);
      } else {
        final errorMessage = ErrorParser.parseErrorResponse(response.body);
        AppLogger.error(
          'Failed to fetch latest episodes',
          'Status: ${response.statusCode}, Body: ${response.body}',
        );
        throw Exception(errorMessage);
      }
    } catch (e) {
      rethrow;
    }
  }

  // Parse latest episodes response
  static LatestEpisodesRes _parseLatestEpisodesResponse(
    Map<String, dynamic> json,
  ) {
    return LatestEpisodesRes(
      message: json['message'] as String,
      data: LatestEpisodesData(
        message: json['data']['message'] as String,
        data: _parsePaginatedEpisodes(
          json['data']['data'] as Map<String, dynamic>,
        ),
      ),
    );
  }

  // Get handpicked episodes
  static Future<HandpickedRes> getHandpicked({
    int amount = 1,
    String? token,
  }) async {
    try {
      final response = await ApiService.get(
        ApiEndpoints.handpicked(amount: amount),
        headers: _buildHeaders(token: token),
      );

      if (ApiService.isSuccess(response.statusCode)) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        AppLogger.info('Handpicked episodes fetched successfully');
        return _parseHandpickedResponse(jsonData);
      } else {
        final errorMessage = ErrorParser.parseErrorResponse(response.body);
        AppLogger.error(
          'Failed to fetch handpicked',
          'Status: ${response.statusCode}, Body: ${response.body}',
        );
        throw Exception(errorMessage);
      }
    } catch (e) {
      rethrow;
    }
  }

  // Parse handpicked response
  static HandpickedRes _parseHandpickedResponse(Map<String, dynamic> json) {
    return HandpickedRes(
      message: json['message'] as String,
      data: HandpickedData(
        message: json['data']['message'] as String,
        data: HandpickedEpisodesData(
          data: (json['data']['data']['data'] as List<dynamic>)
              .map((e) => _parseEpisode(e as Map<String, dynamic>))
              .toList(),
        ),
      ),
    );
  }

  // Get keywords
  static Future<KeywordsRes> getKeywords({
    int page = 1,
    int perPage = 20,
    String? token,
  }) async {
    try {
      final response = await ApiService.get(
        ApiEndpoints.keywords(page: page, perPage: perPage),
        headers: _buildHeaders(token: token),
      );

      if (ApiService.isSuccess(response.statusCode)) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        AppLogger.info('Keywords fetched successfully');
        return _parseKeywordsResponse(jsonData);
      } else {
        final errorMessage = ErrorParser.parseErrorResponse(response.body);
        AppLogger.error(
          'Failed to fetch keywords',
          'Status: ${response.statusCode}, Body: ${response.body}',
        );
        throw Exception(errorMessage);
      }
    } catch (e) {
      rethrow;
    }
  }

  // Parse keywords response
  static KeywordsRes _parseKeywordsResponse(Map<String, dynamic> json) {
    return KeywordsRes(
      message: json['message'] as String,
      data: KeywordsData(
        message: json['data']['message'] as String,
        data: _parsePaginatedKeywords(
          json['data']['data'] as Map<String, dynamic>,
        ),
      ),
    );
  }

  // Parse paginated keywords
  static PaginatedKeywords _parsePaginatedKeywords(Map<String, dynamic> json) {
    return PaginatedKeywords(
      data: (json['data'] as List<dynamic>)
          .map((e) => _parseKeyword(e as Map<String, dynamic>))
          .toList(),
      currentPage: json['current_page'] as int,
      firstPageUrl: json['first_page_url'] as String,
      from: json['from'] as int,
      lastPage: json['last_page'] as int,
      lastPageUrl: json['last_page_url'] as String,
      links: (json['links'] as List<dynamic>)
          .map((e) => _parsePageLink(e as Map<String, dynamic>))
          .toList(),
      nextPageUrl: json['next_page_url'] as String?,
      path: json['path'] as String,
      perPage: json['per_page'] as int,
      prevPageUrl: json['prev_page_url'] as String?,
      to: json['to'] as int,
      total: json['total'] as int,
    );
  }

  // Parse keyword
  static Keyword _parseKeyword(Map<String, dynamic> json) {
    return Keyword(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
