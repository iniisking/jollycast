import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:jollycast/core/model/episodes/get_trending_model.dart';
import 'package:jollycast/utils/logger.dart';

class AudioPlayerController extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();

  Episode? _currentEpisode;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _isBuffering = false;
  bool _isPlaying = false;

  AudioPlayerController() {
    _player.positionStream.listen((pos) {
      _position = pos;
      notifyListeners();
    });

    _player.durationStream.listen((dur) {
      _duration = dur ?? Duration.zero;
      notifyListeners();
    });

    _player.playerStateStream.listen((state) {
      _isBuffering =
          state.processingState == ProcessingState.loading ||
          state.processingState == ProcessingState.buffering;
      _isPlaying = state.playing;
      notifyListeners();
    });
  }

  Episode? get currentEpisode => _currentEpisode;
  Duration get position => _position;
  Duration get duration => _duration;
  bool get isPlaying => _isPlaying;
  bool get isBuffering => _isBuffering;

  Future<void> playEpisode(Episode episode) async {
    if (_currentEpisode?.id == episode.id) {
      return;
    }

    _currentEpisode = episode;
    _isBuffering = true;
    notifyListeners();

    try {
      await _player.setUrl(episode.contentUrl);
      await _player.play();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to play episode ${episode.id}', e, stackTrace);
    } finally {
      _isBuffering = false;
      notifyListeners();
    }
  }

  void togglePlayPause() {
    if (_player.playing) {
      _player.pause();
    } else {
      _player.play();
    }
  }

  void seekRelative(Duration offset) {
    final newPosition = _position + offset;
    final clampedMillis = newPosition.inMilliseconds.clamp(
      0,
      _duration.inMilliseconds,
    );
    _player.seek(Duration(milliseconds: clampedMillis));
  }

  void seekToFraction(double fraction) {
    if (_duration.inMilliseconds == 0) return;
    final targetMillis = (_duration.inMilliseconds * fraction).clamp(
      0,
      _duration.inMilliseconds,
    );
    _player.seek(Duration(milliseconds: targetMillis.round()));
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
