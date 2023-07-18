import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tpstreams_player_sdk/tpstreams_player_sdk.dart';
import '../models/asset.dart';

Future<Asset> fetchAsset(String assetId, String accessToken) async {
  String url = generateAssetURL(assetId, accessToken);
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return Asset.fromJSON(jsonDecode(response.body), accessToken);
  } else {
    throw Exception('Failed to fetch data from API.');
  }
}

String generateAssetURL(String assetId, String accessToken) {
  if (TPStreamsSDK.provider == PROVIDER.tpstreams) {
    return "https://app.tpstreams.com/api/v1/${TPStreamsSDK.orgCode}/assets/$assetId/?access_token=$accessToken";
  }

  return "https://${TPStreamsSDK.orgCode}.testpress.in/api/v2.5/video_info/$assetId?access_token=$accessToken";
}
