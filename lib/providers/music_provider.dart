import 'package:flutter/material.dart';
import '../models/track.dart';
import '../services/api_service.dart';
import '../services/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MusicProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final AudioService _audioService = AudioService();

  List<Track> _tracks = [];
  bool _isLoading = false;
  String? _error;
  int _offset = 0;
  final int _limit = 20;
  String _searchQuery = '';
  bool _hasMore = true;

  Track? _currentTrack;
  bool _isPlaying = false;

  List<Track> get tracks => _tracks;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Track? get currentTrack => _currentTrack;
  bool get isPlaying => _isPlaying;
  AudioPlayer get player => _audioService.player;

  MusicProvider() {
    _audioService.player.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      notifyListeners();
      
      if (state.processingState == ProcessingState.completed) {
        playNext();
      }
    });
    fetchTracks();
  }

  Future<void> fetchTracks({bool isRefresh = false}) async {
    if (_isLoading || (!_hasMore && !isRefresh)) return;

    _isLoading = true;
    _error = null;
    if (isRefresh) {
      _offset = 0;
      _tracks = [];
      _hasMore = true;
    }
    notifyListeners();

    try {
      final newTracks = await _apiService.fetchTracks(
        limit: _limit,
        offset: _offset,
        query: _searchQuery,
      );

      if (newTracks.length < _limit) {
        _hasMore = false;
      }

      _tracks.addAll(newTracks);
      _offset += newTracks.length;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void search(String query) {
    _searchQuery = query;
    fetchTracks(isRefresh: true);
  }

  void playTrack(Track track) {
    _currentTrack = track;
    _audioService.playTrack(track);
    notifyListeners();
  }

  void togglePlay() {
    if (_isPlaying) {
      _audioService.pause();
    } else {
      _audioService.resume();
    }
  }

  void playNext() {
    if (_currentTrack == null || _tracks.isEmpty) return;
    int currentIndex = _tracks.indexWhere((t) => t.id == _currentTrack!.id);
    if (currentIndex < _tracks.length - 1) {
      playTrack(_tracks[currentIndex + 1]);
    }
  }

  void playPrevious() {
    if (_currentTrack == null || _tracks.isEmpty) return;
    int currentIndex = _tracks.indexWhere((t) => t.id == _currentTrack!.id);
    if (currentIndex > 0) {
      playTrack(_tracks[currentIndex - 1]);
    }
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }
}
