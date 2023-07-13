import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tpstreams_player_sdk/tpstreams_player_sdk.dart';
import '../models/asset.dart';

Future<Asset> fetchAsset(String assetId, String accessToken) async {
  String url =
      "https://app.tpstreams.com/api/v1/${TPStreamsSDK.orgCode}/assets/$assetId/?access_token=$accessToken";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return Asset.fromJSON(jsonDecode(response.body), accessToken);
  } else {
    throw Exception('Failed to fetch data from API.');
  }
}
