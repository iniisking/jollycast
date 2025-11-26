import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jollycast/utils/logger.dart';

class CacheService {
  static const String _cacheBoxName = 'api_cache';
  static const Duration _defaultCacheDuration = Duration(hours: 24);
  static Box? _box;

  /// Initialize the cache service
  static Future<void> init() async {
    try {
      await Hive.initFlutter();
      _box = await Hive.openBox(_cacheBoxName);
      AppLogger.info('Cache service initialized');
    } catch (e) {
      AppLogger.error('Failed to initialize cache service: $e');
      rethrow;
    }
  }

  /// Generate a cache key from URL and query parameters
  static String _generateCacheKey(
    String url,
    Map<String, dynamic>? queryParams,
  ) {
    final uri = Uri.parse(url);
    final key = uri.toString();
    if (queryParams != null && queryParams.isNotEmpty) {
      final sortedParams = Map.fromEntries(
        queryParams.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
      );
      return '$key?${Uri(queryParameters: sortedParams.map((k, v) => MapEntry(k, v.toString()))).query}';
    }
    return key;
  }

  /// Save API response to cache
  static Future<void> saveResponse(
    String url,
    String responseBody,
    Map<String, dynamic>? queryParams, {
    Duration? cacheDuration,
  }) async {
    try {
      if (_box == null) {
        AppLogger.warning('Cache box not initialized');
        return;
      }

      final key = _generateCacheKey(url, queryParams);
      final expiresAt = DateTime.now()
          .add(cacheDuration ?? _defaultCacheDuration)
          .toIso8601String();

      final cacheData = {
        'body': responseBody,
        'expiresAt': expiresAt,
        'cachedAt': DateTime.now().toIso8601String(),
      };

      await _box!.put(key, jsonEncode(cacheData));
      AppLogger.info('Cached response for: $key');
    } catch (e) {
      AppLogger.error('Failed to save cache: $e');
    }
  }

  /// Get cached API response if available and not expired
  static String? getCachedResponse(
    String url,
    Map<String, dynamic>? queryParams,
  ) {
    try {
      if (_box == null) {
        AppLogger.warning('Cache box not initialized');
        return null;
      }

      final key = _generateCacheKey(url, queryParams);
      final cachedDataJson = _box!.get(key);

      if (cachedDataJson == null) {
        return null;
      }

      final cachedData =
          jsonDecode(cachedDataJson as String) as Map<String, dynamic>;
      final expiresAt = DateTime.parse(cachedData['expiresAt'] as String);

      // Check if cache is expired
      if (DateTime.now().isAfter(expiresAt)) {
        // Remove expired cache
        _box!.delete(key);
        AppLogger.info('Cache expired for: $key');
        return null;
      }

      AppLogger.info('Retrieved cached response for: $key');
      return cachedData['body'] as String;
    } catch (e) {
      AppLogger.error('Failed to get cached response: $e');
      return null;
    }
  }

  /// Check if a cached response exists and is valid
  static bool hasCachedResponse(String url, Map<String, dynamic>? queryParams) {
    try {
      if (_box == null) return false;

      final key = _generateCacheKey(url, queryParams);
      final cachedDataJson = _box!.get(key);

      if (cachedDataJson == null) {
        return false;
      }

      final cachedData =
          jsonDecode(cachedDataJson as String) as Map<String, dynamic>;
      final expiresAt = DateTime.parse(cachedData['expiresAt'] as String);

      return !DateTime.now().isAfter(expiresAt);
    } catch (e) {
      return false;
    }
  }

  /// Clear all cached responses
  static Future<void> clearCache() async {
    try {
      if (_box == null) return;
      await _box!.clear();
      AppLogger.info('Cache cleared');
    } catch (e) {
      AppLogger.error('Failed to clear cache: $e');
    }
  }

  /// Clear cache for a specific URL
  static Future<void> clearCacheForUrl(
    String url,
    Map<String, dynamic>? queryParams,
  ) async {
    try {
      if (_box == null) return;
      final key = _generateCacheKey(url, queryParams);
      await _box!.delete(key);
      AppLogger.info('Cache cleared for: $key');
    } catch (e) {
      AppLogger.error('Failed to clear cache for URL: $e');
    }
  }

  /// Get cache size (approximate)
  static int getCacheSize() {
    try {
      if (_box == null) return 0;
      return _box!.length;
    } catch (e) {
      return 0;
    }
  }
}
