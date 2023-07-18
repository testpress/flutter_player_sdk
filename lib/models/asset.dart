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
    Video video;
    if (TPStreamsSDK.provider == PROVIDER.tpstreams) {
      video = Video.fromStreamsResponse(json['video']);
    } else {
      video = Video.fromTestpressResponse(json);
    }

    return Asset(
        id: json['id'],
        title: json['title'],
        video: video,
        accessToken: accessToken);
  }

  String get licenseURL {
    var url = TPStreamsSDK.provider == PROVIDER.tpstreams
        ? 'https://app.tpstreams.com/api/v1/${TPStreamsSDK.orgCode}/assets/$id/drm_license/?access_token=$accessToken'
        : 'https://${TPStreamsSDK.orgCode}.testpress.in/api/v2.5/drm_license_key/$id/?access_token=$accessToken';

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

  factory Video.fromStreamsResponse(Map<String, dynamic> json) {
    return Video(
        playbackURL: json['playback_url'],
        dashURL: json['dash_url'],
        status: json['status'],
        drmEnabled: json["enable_drm"]);
  }

  factory Video.fromTestpressResponse(Map<String, dynamic> json) {
    bool drmEnabled = json["drm_enabled"];

    return Video(
        playbackURL: drmEnabled ? json['hls_url'] : json['url'],
        dashURL: drmEnabled ? json['dash_url'] : "",
        status: json['transcoding_status'],
        drmEnabled: drmEnabled);
  }

  String getPlaybackURL() {
    return drmEnabled && Platform.isAndroid ? dashURL : playbackURL;
  }
}
