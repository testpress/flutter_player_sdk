import 'dart:io';

import '../tpstreams_player_sdk.dart';

class Asset {
  final String id;
  final String title;
  final Video video;
  final String accessToken;

  Asset(
      {required this.id,
      required this.title,
      required this.video,
      required this.accessToken});

  factory Asset.fromJSON(Map<String, dynamic> json, String accessToken) {
    return Asset(
        id: json['id'],
        title: json['title'],
        video: Video.fromJSON(json['video']),
        accessToken: accessToken);
  }

  String get licenseURL {
    var url =
        'https://app.tpstreams.com/api/v1/${TPStreamsSDK.orgCode}/assets/$id/drm_license/?access_token=$accessToken';
    if (Platform.isIOS) {
      url += '&drm_type=fairplay';
    }
    return url;
  }

  String? get certificateURL {
    if (Platform.isIOS) {
      return 'https://app.tpstreams.com/static/fairplay.cer';
    }
    return null;
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

  String getPlaybackURL() {
    return drmEnabled && Platform.isAndroid ? dashURL : playbackURL;
  }
}
