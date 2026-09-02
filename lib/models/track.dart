class Track {
  final String id;
  final String name;
  final int duration;
  final String artistName;
  final String albumName;
  final String albumImage;
  final String audio;
  final String image;

  Track({
    required this.id,
    required this.name,
    required this.duration,
    required this.artistName,
    required this.albumName,
    required this.albumImage,
    required this.audio,
    required this.image,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      duration: json['duration'] ?? 0,
      artistName: json['artist_name'] ?? '',
      albumName: json['album_name'] ?? '',
      albumImage: json['album_image'] ?? '',
      audio: json['audio'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
