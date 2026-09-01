import 'package:just_audio/just_audio.dart';
import '../models/track.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;

  Future<void> playTrack(Track track) async {
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(track.audio)));
      _player.play();
    } catch (e) {
      print("Error playing track: $e");
    }
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> resume() async {
    await _player.play();
  }

  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  void dispose() {
    _player.dispose();
  }
}
