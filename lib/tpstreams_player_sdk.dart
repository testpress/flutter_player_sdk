library tpstreams_player_sdk;

export 'widgets/player.dart';

class TPStreamsSDK {
  static String? _orgCode;

  static void initialize({required String orgCode}) {
    if (orgCode.isEmpty) {
      throw Exception("Given OrgCode is empty, please pass a valid orgCode");
    }

    _orgCode = orgCode;
  }

  static String get orgCode {
    if (_orgCode == null) {
      throw Exception("OrgCode has not been initialized");
    }

    return _orgCode!;
  }

  static bool get isInitialized => _orgCode != null;
}
