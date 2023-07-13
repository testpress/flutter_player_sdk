import 'dart:ffi';
import 'dart:io';

class Asset {
  final String id;
  final String title;
  final Video video;

  Asset({
    required this.id,
    required this.title,
    required this.video,
  });

  factory Asset.fromJSON(Map<String, dynamic> json) {
    return Asset(
      id: json['id'],
      title: json['title'],
      video: Video.fromJSON(json['video']),
    );
  }
}

class Video {
  final String playbackURL;
  final String dashURL;
  final String status;
  final bool drmEnabled;

  Video(
      {required this.playbackURL,
      required this.status,
      required this.dashURL,
      required this.drmEnabled});

  factory Video.fromJSON(Map<String, dynamic> json) {
    return Video(
        playbackURL: json['playback_url'],
        dashURL: json['dash_url'],
        status: json['status'],
        drmEnabled: json["enable_drm"]);
  }

  String getPlaybackURL(){
    return drmEnabled && Platform.isAndroid ? dashURL : playbackURL;
  }
}
