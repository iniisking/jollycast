import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static String get baseUrl {
    try {
      return dotenv.env['API_BASE_URL'] ?? 'https://api.jollypodcast.net/api';
    } catch (e) {
      // dotenv not initialized (e.g., .env file not found)
      return 'https://api.jollypodcast.net/api';
    }
  }

  // Auth endpoints
  static String get login => '$baseUrl/auth/login';

  // Episodes endpoints
  static String trendingEpisodes({int page = 1, int perPage = 1}) {
    return '$baseUrl/episodes/trending?page=$page&per_page=$perPage';
  }

  static String get editorsPick => '$baseUrl/episodes/editor-pick';

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
