import 'package:flutter/foundation.dart';
import 'package:jollycast/core/model/episodes/get_trending_model.dart';
import 'package:jollycast/core/model/episodes/editors_pick_model.dart';
import 'package:jollycast/core/model/episodes/top_jolly_model.dart';
import 'package:jollycast/core/model/episodes/latest_episodes_model.dart';
import 'package:jollycast/core/model/episodes/handpicked_model.dart';
import 'package:jollycast/core/model/episodes/keywords_model.dart';
import 'package:jollycast/core/services/episodes_service.dart';
import 'package:jollycast/utils/toast_infos.dart';
import 'package:jollycast/utils/error_parser.dart';
import 'package:jollycast/utils/logger.dart';
import 'package:jollycast/utils/auth_exception.dart';

class EpisodesController extends ChangeNotifier {
  VoidCallback? _onAuthError;
  bool _isLoading = false;
  bool _isLoadingEditorsPick = false;
  bool _isLoadingTopJolly = false;
  bool _isLoadingLatestEpisodes = false;
  bool _isLoadingHandpicked = false;
  bool _isLoadingKeywords = false;
  GetTrendingRes? _trendingResponse;
  List<Episode> _trendingEpisodes = [];
  PaginatedEpisodes? _pagination;
  EditorsPickRes? _editorsPickResponse;
  Episode? _editorsPickEpisode;
  TopJollyRes? _topJollyResponse;
  List<TopJollyPodcast> _topJollyPodcasts = [];
  PaginatedTopJollyPodcasts? _topJollyPagination;
  LatestEpisodesRes? _latestEpisodesResponse;
  List<Episode> _latestEpisodes = [];
  PaginatedEpisodes? _latestEpisodesPagination;
  HandpickedRes? _handpickedResponse;
  List<Episode> _handpickedEpisodes = [];
  KeywordsRes? _keywordsResponse;
  List<Keyword> _keywords = [];
  PaginatedKeywords? _keywordsPagination;
  Episode? _currentEpisode;
  bool _isLoadingEpisode = false;

  bool get isLoading => _isLoading;
  bool get isLoadingEditorsPick => _isLoadingEditorsPick;
  bool get isLoadingTopJolly => _isLoadingTopJolly;
  bool get isLoadingLatestEpisodes => _isLoadingLatestEpisodes;
  bool get isLoadingHandpicked => _isLoadingHandpicked;
  bool get isLoadingKeywords => _isLoadingKeywords;
  List<Episode> get trendingEpisodes => _trendingEpisodes;
  PaginatedEpisodes? get pagination => _pagination;
  Episode? get editorsPickEpisode => _editorsPickEpisode;
  List<TopJollyPodcast> get topJollyPodcasts => _topJollyPodcasts;
  PaginatedTopJollyPodcasts? get topJollyPagination => _topJollyPagination;
  List<Episode> get latestEpisodes => _latestEpisodes;
  PaginatedEpisodes? get latestEpisodesPagination => _latestEpisodesPagination;
  List<Episode> get handpickedEpisodes => _handpickedEpisodes;
  List<Keyword> get keywords => _keywords;
  PaginatedKeywords? get keywordsPagination => _keywordsPagination;
  Episode? get currentEpisode => _currentEpisode;
  bool get isLoadingEpisode => _isLoadingEpisode;
  bool get hasMorePages =>
      _pagination != null && _pagination!.nextPageUrl != null;
  bool get hasMoreTopJollyPages =>
      _topJollyPagination != null && _topJollyPagination!.nextPageUrl != null;
  bool get hasMoreLatestEpisodesPages =>
      _latestEpisodesPagination != null &&
      _latestEpisodesPagination!.nextPageUrl != null;
  bool get hasMoreKeywordsPages =>
      _keywordsPagination != null && _keywordsPagination!.nextPageUrl != null;

  // Set callback for handling authentication errors
  void setAuthErrorHandler(VoidCallback onAuthError) {
    _onAuthError = onAuthError;
  }

  // Get trending episodes
  Future<bool> getTrendingEpisodes({
    int page = 1,
    int perPage = 1,
    bool append = false,
    String? token,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      _trendingResponse = await EpisodesService.getTrendingEpisodes(
        page: page,
        perPage: perPage,
        token: token,
      );

      _pagination = _trendingResponse!.data.data;

      if (append) {
        _trendingEpisodes.addAll(_pagination!.data);
      } else {
        _trendingEpisodes = _pagination!.data;
      }

      _isLoading = false;
      notifyListeners();

      AppLogger.info(
        'Trending episodes loaded: ${_trendingEpisodes.length} episodes',
      );
      toastInfo(msg: _trendingResponse!.message);
      return true;
    } catch (e, stackTrace) {
      _isLoading = false;
      notifyListeners();

      if (e is AuthenticationException) {
        _onAuthError?.call();
        return false;
      }

      final errorMessage = ErrorParser.extractErrorMessage(e);
      AppLogger.error('Failed to load trending episodes', e, stackTrace);
      toastError(msg: errorMessage);
      return false;
    }
  }

  // Load more episodes (next page)
  Future<bool> loadMoreTrendingEpisodes({String? token}) async {
    if (!hasMorePages || _isLoading) return false;

    final nextPage = _pagination!.currentPage + 1;
    return await getTrendingEpisodes(
      page: nextPage,
      perPage: _pagination!.perPage,
      append: true,
      token: token,
    );
  }

  // Refresh trending episodes
  Future<bool> refreshTrendingEpisodes({String? token}) async {
    return await getTrendingEpisodes(
      page: 1,
      perPage: _pagination?.perPage ?? 1,
      token: token,
    );
  }

  // Get editor's pick
  Future<bool> getEditorsPick({String? token}) async {
    _isLoadingEditorsPick = true;
    notifyListeners();

    try {
      _editorsPickResponse = await EpisodesService.getEditorsPick(token: token);
      _editorsPickEpisode = _editorsPickResponse!.data.episode;

      _isLoadingEditorsPick = false;
      notifyListeners();

      AppLogger.info('Editor\'s pick loaded successfully');
      toastInfo(msg: _editorsPickResponse!.message);
      return true;
    } catch (e, stackTrace) {
      _isLoadingEditorsPick = false;
      notifyListeners();

      if (e is AuthenticationException) {
        _onAuthError?.call();
        return false;
      }

      final errorMessage = ErrorParser.extractErrorMessage(e);
      AppLogger.error('Failed to load editor\'s pick', e, stackTrace);
      toastError(msg: errorMessage);
      return false;
    }
  }

  // Get top jolly podcasts
  Future<bool> getTopJolly({
    int page = 1,
    int perPage = 1,
    bool append = false,
    String? token,
  }) async {
    _isLoadingTopJolly = true;
    notifyListeners();

    try {
      _topJollyResponse = await EpisodesService.getTopJolly(
        page: page,
        perPage: perPage,
        token: token,
      );

      _topJollyPagination = _topJollyResponse!.data.data;

      if (append) {
        _topJollyPodcasts.addAll(_topJollyPagination!.data);
      } else {
        _topJollyPodcasts = _topJollyPagination!.data;
      }

      _isLoadingTopJolly = false;
      notifyListeners();

      AppLogger.info('Top jolly loaded: ${_topJollyPodcasts.length} podcasts');
      toastInfo(msg: _topJollyResponse!.message);
      return true;
    } catch (e, stackTrace) {
      _isLoadingTopJolly = false;
      notifyListeners();

      if (e is AuthenticationException) {
        _onAuthError?.call();
        return false;
      }

      final errorMessage = ErrorParser.extractErrorMessage(e);
      AppLogger.error('Failed to load top jolly', e, stackTrace);
      toastError(msg: errorMessage);
      return false;
    }
  }

  // Load more top jolly podcasts (next page)
  Future<bool> loadMoreTopJolly({String? token}) async {
    if (!hasMoreTopJollyPages || _isLoadingTopJolly) return false;

    final nextPage = _topJollyPagination!.currentPage + 1;
    return await getTopJolly(
      page: nextPage,
      perPage: _topJollyPagination!.perPage,
      append: true,
      token: token,
    );
  }

  // Refresh top jolly podcasts
  Future<bool> refreshTopJolly({String? token}) async {
    return await getTopJolly(
      page: 1,
      perPage: _topJollyPagination?.perPage ?? 1,
      token: token,
    );
  }

  // Get latest episodes
  Future<bool> getLatestEpisodes({
    int page = 1,
    int perPage = 20,
    bool append = false,
    String? token,
  }) async {
    _isLoadingLatestEpisodes = true;
    notifyListeners();

    try {
      _latestEpisodesResponse = await EpisodesService.getLatestEpisodes(
        page: page,
        perPage: perPage,
        token: token,
      );

      _latestEpisodesPagination = _latestEpisodesResponse!.data.data;

      if (append) {
        _latestEpisodes.addAll(_latestEpisodesPagination!.data);
      } else {
        _latestEpisodes = _latestEpisodesPagination!.data;
      }

      _isLoadingLatestEpisodes = false;
      notifyListeners();

      AppLogger.info(
        'Latest episodes loaded: ${_latestEpisodes.length} episodes',
      );
      toastInfo(msg: _latestEpisodesResponse!.message);
      return true;
    } catch (e, stackTrace) {
      _isLoadingLatestEpisodes = false;
      notifyListeners();

      if (e is AuthenticationException) {
        _onAuthError?.call();
        return false;
      }

      final errorMessage = ErrorParser.extractErrorMessage(e);
      AppLogger.error('Failed to load latest episodes', e, stackTrace);
      toastError(msg: errorMessage);
      return false;
    }
  }

  // Load more latest episodes (next page)
  Future<bool> loadMoreLatestEpisodes({String? token}) async {
    if (!hasMoreLatestEpisodesPages || _isLoadingLatestEpisodes) return false;

    final nextPage = _latestEpisodesPagination!.currentPage + 1;
    return await getLatestEpisodes(
      page: nextPage,
      perPage: _latestEpisodesPagination!.perPage,
      append: true,
      token: token,
    );
  }

  // Refresh latest episodes
  Future<bool> refreshLatestEpisodes({String? token}) async {
    return await getLatestEpisodes(
      page: 1,
      perPage: _latestEpisodesPagination?.perPage ?? 20,
      token: token,
    );
  }

  // Get handpicked episodes
  Future<bool> getHandpicked({int amount = 1, String? token}) async {
    _isLoadingHandpicked = true;
    notifyListeners();

    try {
      _handpickedResponse = await EpisodesService.getHandpicked(
        amount: amount,
        token: token,
      );
      _handpickedEpisodes = _handpickedResponse!.data.data.data;

      _isLoadingHandpicked = false;
      notifyListeners();

      AppLogger.info(
        'Handpicked episodes loaded: ${_handpickedEpisodes.length} episodes',
      );
      toastInfo(msg: _handpickedResponse!.message);
      return true;
    } catch (e, stackTrace) {
      _isLoadingHandpicked = false;
      notifyListeners();

      if (e is AuthenticationException) {
        _onAuthError?.call();
        return false;
      }

      final errorMessage = ErrorParser.extractErrorMessage(e);
      AppLogger.error('Failed to load handpicked episodes', e, stackTrace);
      toastError(msg: errorMessage);
      return false;
    }
  }

  // Get keywords
  Future<bool> getKeywords({
    int page = 1,
    int perPage = 20,
    bool append = false,
    String? token,
  }) async {
    _isLoadingKeywords = true;
    notifyListeners();

    try {
      _keywordsResponse = await EpisodesService.getKeywords(
        page: page,
        perPage: perPage,
        token: token,
      );

      _keywordsPagination = _keywordsResponse!.data.data;

      if (append) {
        _keywords.addAll(_keywordsPagination!.data);
      } else {
        _keywords = _keywordsPagination!.data;
      }

      _isLoadingKeywords = false;
      notifyListeners();

      AppLogger.info('Keywords loaded: ${_keywords.length} keywords');
      toastInfo(msg: _keywordsResponse!.message);
      return true;
    } catch (e, stackTrace) {
      _isLoadingKeywords = false;
      notifyListeners();

      if (e is AuthenticationException) {
        _onAuthError?.call();
        return false;
      }

      final errorMessage = ErrorParser.extractErrorMessage(e);
      AppLogger.error('Failed to load keywords', e, stackTrace);
      toastError(msg: errorMessage);
      return false;
    }
  }

  // Load more keywords (next page)
  Future<bool> loadMoreKeywords({String? token}) async {
    if (!hasMoreKeywordsPages || _isLoadingKeywords) return false;

    final nextPage = _keywordsPagination!.currentPage + 1;
    return await getKeywords(
      page: nextPage,
      perPage: _keywordsPagination!.perPage,
      append: true,
      token: token,
    );
  }

  // Refresh keywords
  Future<bool> refreshKeywords({String? token}) async {
    return await getKeywords(
      page: 1,
      perPage: _keywordsPagination?.perPage ?? 20,
      token: token,
    );
  }

  // Get single episode by id
  Future<Episode?> getEpisodeById({required int id, String? token}) async {
    _isLoadingEpisode = true;
    notifyListeners();

    try {
      final episode = await EpisodesService.getEpisodeById(
        id: id,
        token: token,
      );

      _currentEpisode = episode;
      _isLoadingEpisode = false;
      notifyListeners();

      AppLogger.info('Episode $id loaded successfully');
      return episode;
    } catch (e, stackTrace) {
      _isLoadingEpisode = false;
      notifyListeners();

      if (e is AuthenticationException) {
        _onAuthError?.call();
        return null;
      }

      final errorMessage = ErrorParser.extractErrorMessage(e);
      AppLogger.error('Failed to load episode $id', e, stackTrace);
      toastError(msg: errorMessage);
      return null;
    }
  }

  // Clear episodes
  void clearEpisodes() {
    _trendingEpisodes = [];
    _trendingResponse = null;
    _pagination = null;
    _editorsPickResponse = null;
    _editorsPickEpisode = null;
    _topJollyResponse = null;
    _topJollyPodcasts = [];
    _topJollyPagination = null;
    _latestEpisodesResponse = null;
    _latestEpisodes = [];
    _latestEpisodesPagination = null;
    _handpickedResponse = null;
    _handpickedEpisodes = [];
    _keywordsResponse = null;
    _keywords = [];
    _keywordsPagination = null;
    notifyListeners();
  }
}
