class ApiEndpoints {
  static const String baseUrl = 'https://api.jollypodcast.net/api';

  // Auth endpoints
  static const String login = '$baseUrl/auth/login';

  // Episodes endpoints
  static String trendingEpisodes({int page = 1, int perPage = 1}) {
    return '$baseUrl/episodes/trending?page=$page&per_page=$perPage';
  }

  static const String editorsPick = '$baseUrl/episodes/editor-pick';

  static String topJolly({int page = 1, int perPage = 1}) {
    return '$baseUrl/podcasts/top-jolly?page=$page&per_page=$perPage';
  }

  static String latestEpisodes({int page = 1, int perPage = 20}) {
    return '$baseUrl/episodes/latest?page=$page&per_page=$perPage';
  }

  static String handpicked({int amount = 1}) {
    return '$baseUrl/podcasts/handpicked?amount=$amount';
  }

  static String keywords({int page = 1, int perPage = 20}) {
    return '$baseUrl/podcasts/keywords?page=$page&per_page=$perPage';
  }

  static String episode(int id) {
    return '$baseUrl/episodes/$id';
  }
}
